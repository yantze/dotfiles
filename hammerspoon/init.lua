-- ref:
-- https://spinscale.de/posts/2016-11-08-creating-a-productive-osx-environment-hammerspoon.html

hs.window.animationDuration = 0

--[[ function factory that takes the multipliers of screen width
and height to produce the window's x pos, y pos, width, and height ]]
function baseMove(x, y, w, h)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        -- add max.x so it stays on the same screen, works with my second screen
        f.x = max.w * x + max.x
        f.y = max.h * y
        f.w = max.w * w
        f.h = max.h * h
        win:setFrame(f, 0)
    end
end

-- feature spectacle/another window sizing apps
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Left', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Right', baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Down', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'Up', baseMove(0, 0, 1, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '1', baseMove(0, 0, 0.5, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '2', baseMove(0.5, 0, 0.5, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '3', baseMove(0, 0.5, 0.5, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, '4', baseMove(0.5, 0.5, 0.5, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'M', hs.grid.maximizeWindow)

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'H', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'L', baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'J', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'K', baseMove(0, 0, 1, 0.5))


-- quick jump to important applications
hs.grid.setMargins({0, 0})
hs.hotkey.bind({'alt'}, '1', function () hs.application.launchOrFocus("Google Chrome") end)
-- even though the app is named iTerm2, iTerm is the correct name
-- hs.hotkey.bind({'alt'}, '2', function () hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind({'alt'}, '2', function () hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind({'alt'}, '3', function () hs.application.launchOrFocusByBundleID("com.google.Chrome.app.Default-koegeopamaoljbmhnfjbclbocehhgmkm") end)
hs.hotkey.bind({'ctrl', 'shift'}, 'escape', function () hs.application.launchOrFocus("Activity Monitor") end)
hs.hotkey.bind({'alt'}, 'e', function () hs.application.launchOrFocus("Finder") end)
hs.hotkey.bind({'alt'}, 'w', function () hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind({'alt'}, 'q', function () hs.application.launchOrFocus("Telegram") end)


-- Load config notification
hs.notify.new({title="Hammerspoon config reloaded", informativeText="Manually via menu click"}):send()
