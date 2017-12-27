-- require 'clipboard'
-- require 'slowq'
-- require 'vim'
-- local vimouse = require('vimouse')
-- vimouse('cmd', 'm')


hs.window.animationDuration = 0 -- disable animations
hs.grid.setMargins({0, 0})
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

hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'M', hs.grid.maximizeWindow)
hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'C', baseMove(0.25, 0.25, 0.5, 0.5))

hs.hotkey.bind({'ctrl', 'cmd'}, 'Left', baseMove(0, 0, 1/3, 1))
hs.hotkey.bind({'ctrl', 'cmd'}, 'Right', baseMove(2/3, 0, 1/3, 1))
hs.hotkey.bind({'alt', 'shift', 'cmd'}, 'Left', baseMove(0, 0, 2/3, 1))
hs.hotkey.bind({'alt', 'shift', 'cmd'}, 'Right', baseMove(1/3, 0, 2/3, 1))

-- reload config
function reloadConfig(files) -- `files` available in pathwatcher
  hs.reload()
  hs.notify.new({title="Hammerspoon config reloaded", informativeText="By user operation"}):send()
  -- hs.alert.show("loaded")
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", reloadConfig)
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()


-- quick jump to important applications
hs.hotkey.bind({'alt'}, '1', function () hs.application.launchOrFocusByBundleID("com.google.Chrome") end)
-- even though the app is named iTerm2, iTerm is the correct name
hs.hotkey.bind({'alt'}, '2', function () hs.application.launchOrFocus("iTerm") end)
-- hs.hotkey.bind({'alt'}, '2', function () hs.application.launchOrFocus("Terminal") end)
-- get Bundle ID by: osascript -e 'id of app "Finder"'
-- or try this way: /usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' /Applications/Safari.app/Contents/Info.plist
-- more way: https://superuser.com/questions/346369/getting-the-bundle-identifier-of-an-os-x-application-in-a-shell-script
hs.hotkey.bind({'alt'}, '3', function () hs.application.launchOrFocusByBundleID("com.google.Chrome.app.Default-koegeopamaoljbmhnfjbclbocehhgmkm") end)
hs.hotkey.bind({'alt'}, '4', function () hs.application.launchOrFocusByBundleID("com.google.Chrome.app.Profile-4-koegeopamaoljbmhnfjbclbocehhgmkm") end)
hs.hotkey.bind({'ctrl', 'shift'}, 'escape', function () hs.application.launchOrFocus("Activity Monitor") end)
hs.hotkey.bind({'alt'}, 'e', function () hs.application.launchOrFocus("Finder") end)
hs.hotkey.bind({'alt'}, 'w', function () hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind({'alt'}, 'q', function () hs.application.launchOrFocus("Telegram") end)
hs.hotkey.bind({'alt'}, 'v', function () hs.application.launchOrFocusByBundleID("org.vim.MacVim") end)


-- utils
-- hs.hotkey.bind({'cmd'}, 'j', function () hs.eventtap.keyStroke({}, "down") end)


function scrollLine(x, y)
  return function ()
    hs.eventtap.event.newScrollEvent({x, y}, {}, 'line'):post()
  end
end
-- scroll down
hs.hotkey.bind({'cmd'}, 'k', scrollLine(0, 6), nil, scrollLine(0, 6))
-- scroll up
hs.hotkey.bind({'cmd'}, 'j', scrollLine(0, -6), nil, scrollLine(0, -6))



-- lock screen and start screensaver
-- hs.hotkey.bind({'alt', 'ctrl'}, 'L', function() hs.caffeinate.startScreensaver() end)

-- sleep system immediately
hs.hotkey.bind({'alt', 'cmd'}, 'f15', function() hs.caffeinate.systemSleep() end)

-- TODO force quit app
-- hs

function brightPlus()
  local current = hs.brightness.get()
  if current < 0 then -- unsupport change brightness
    return
  end

  local bright = current + 5
  if (bright > 100) then
    hs.brightness.set(100)
  else
    hs.brightness.set(bright)
  end
end

function brightMinus()
  local current = hs.brightness.get()
  if (current < 0) then
    return
  end

  local bright = current - 5
  if (current < 0) then
    hs.brightness.set(0)
  else
    hs.brightness.set(bright)
  end
end

hs.hotkey.bind({'alt', 'cmd'}, '-', brightPlus)
hs.hotkey.bind({'alt', 'cmd'}, '=', brightMinus)

--
-- hs.hotkey.bind({'ctrl', 'cmd'}, '1', function ()
--   hs.eventtap.keyStroke({},'escape')
--   hs.eventtap.keyStroke({},'shift')
-- end)

-- rcmd_tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
--     local whichFlags = event:getFlags()
--     if whichFlags['cmd'] then
--         hs.eventtap.keyStroke({"alt"}, "")
--     end
-- end)


-- TODO hold cmd and move window by mouse
-- TODO change sound vol
-- TODO change screen display
-- TODO funcstion list
--      copy file path
--      show file md5
--      show file sha1
