--[[

Prevent the screen from blanking while a video is playing.

This script is a workaround for the GNOME+Wayland issue documented in the
[Disabling Screensaver] section of the mpv manual, and depends on
gnome-session-inhibit (usually provided by the gnome-session package) to set up
the inhibitors.


# CAVEATS

This is not (yet?) a foolproof solution.

At this time GNOME's implementation of the Inhibit protocol does not support the
SimluateUserActivity method:

    dbus-send --print-reply --session \
      --dest=org.gnome.ScreenSaver --type=method_call \
      /org/gnome/ScreenSaver org.gnome.ScreenSaver.SimulateUserActivity

So there seems to be no way to "poke" the system with a heartbeat to extend to
idle timeout for a bit and prevent blanking.

This means that inhibitors have to be installed, then removed when mpv exits.

The current implementation handles this via another application, which should
alwasy be available on GNOME+Wayland desktops (because provided by gnome-session
itself): gnome-session-inhibit.

Executing gnome-session-inhibit to handle this is not ideal because if mpv does
not exit cleanly, gnome-session-inhibit is not necessarily killed (it can get
ophaned, and gets adopted by the init process), leaving the inhibitors intact
with no easy way for the user to figure it out.

Ideally this script should open a DBus session directly to handle the
inhibitors, as they would be removed if the DBus session gets disconnected (cf.
[Inhibit's documentation][Inhibit]):

> Applications should invoke [Inhibit ()] when they begin an operation that
> should not be interrupted [...] When the application completes the operation
> it should call Uninhibit() or disconnect from the session bus.

This is how [other applications] do it.

But really, the only secure way to handle this would be with a heartbeat to
regularly reset the idle timer, i.e. what SimulateUserActivity is supposed to
provide. Especially for a core security feature such as screen locking (cf.
xscreensaver's author [rant][jwz]).


# TODO

- Do not inhibit for audio-only playback, only for video
- Fix inhibitors not removed when mpv does not terminate gracefully, e.g. with
  `kill -9 <pid>`, either by having a wrapper around gnome-session-inhibit
  checking the parent PID (see https://stackoverflow.com/a/2035683), or by
  interfacing with dbus to open a session that gets disconnected if mpv
  terminates uncleanly (hopefully), or ...
- Investigate whether the 'playback-abort' event should be handled
- Only inhibit when the player is visible


[Disabling Screensaver]: https://mpv.io/manual/master/#disabling-screensaver
[Inhibit]: https://people.gnome.org/~mccann/gnome-session/docs/gnome-session.html#org.gnome.SessionManager.Inhibit
[jwz]: https://www.jwz.org/blog/2021/01/i-told-you-so-2021-edition/
[other applications]: https://unix.stackexchange.com/a/438335

]]


local mp = require 'mp'
local msg = require 'mp.msg'

local cookie

local function handle_inhibit(_, paused)
    if paused and cookie then
        mp.abort_async_command(cookie)
        cookie = nil
        msg.debug('inhibit off')
    elseif not paused and not cookie then
        cookie = mp.command_native_async(
            {
                name = 'subprocess',
                args = {
                    'gnome-session-inhibit',
                    '--inhibit-only',
                    '--inhibit', 'idle',
                    '--app-id', 'mpv',
                    '--reason', 'video-playing',
                },

                -- `playback_only = true` does not kill the command when
                -- playback is paused (i.e. "pause" is still "playback == true")
                -- but also kills it immediately the first time.
                -- So we need to handle the paused state ourselves.
                playback_only = false,

                -- If not captured, mpv will just forward everything to stdout
                -- and stderr. Setting capture_stdXXX with capture_size = 0 will
                -- ensure that the command's output is discarded.
                capture_stdout = true,
                capture_stderr = true,
                capture_size = 0,
            },

            -- Should be optional according to the doc, but I get an error if I
            -- don't provide a function: attempt to call local 'cb' (a nil value)
            function() end
        )

        msg.debug('inhibit on')
    end
end

mp.observe_property('stop-screensaver', 'bool', function(_, enable)
    if enable then
        mp.observe_property('pause', 'bool', handle_inhibit)
        msg.debug('inhibit handling on')
    else
        mp.unobserve_property('pause', 'bool', handle_inhibit)
        msg.debug('inhibit handling off')

        if cookie then
            mp.abort_async_command(cookie)
            cookie = nil
            msg.debug('inhibit off')
        end
    end
end)