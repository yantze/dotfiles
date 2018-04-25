-- require 'clipboard'
-- require 'slowq'
-- require 'vim'
-- local vimouse = require('vimouse')
-- vimouse('cmd', 'm')

-- Define default Spoons which will be loaded later
if not hspoon_list then
    hspoon_list = {
        "ClipShow",
        "WinWin",
        "FnMate",
        "UnsplashZ"
    }
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
    hs.loadSpoon(v)
end

-- 

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

super = {"ctrl", "alt", "cmd"}
-- feature spectacle/another window sizing apps
hs.hotkey.bind(super, 'Left', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind(super, 'Right', baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind(super, 'Down', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind(super, 'Up', baseMove(0, 0, 1, 0.5))

hs.hotkey.bind(super, 'M', hs.grid.maximizeWindow)
hs.hotkey.bind(super, 'C', baseMove(0.25, 0.25, 0.5, 0.5))

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
hs.hotkey.bind(super, "R", reloadConfig)
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()


-- quick jump to important applications
hs.hotkey.bind({'alt'}, '1', function () hs.application.launchOrFocusByBundleID("com.google.Chrome") end)
-- hs.hotkey.bind({'alt'}, '1', function () hs.osascript.applescript([[
--     tell application "Google Chrome"
--         activate
--     end tell
--   ]]) end)
-- even though the app is named iTerm2, iTerm is the correct name
hs.hotkey.bind({'alt'}, '2', function () hs.application.launchOrFocus("iTerm") end)
-- hs.hotkey.bind({'alt'}, '2', function () hs.application.launchOrFocus("Terminal") end)
-- get all Process Name: osascript -e 'tell application "System Events" to get name of every process'
-- get Bundle ID by: osascript -e 'id of app "Finder"'
-- or try this way: /usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' /Applications/Safari.app/Contents/Info.plist
-- more way: https://superuser.com/questions/346369/getting-the-bundle-identifier-of-an-os-x-application-in-a-shell-script
-- hs.hotkey.bind({'alt'}, '3', function () hs.application.launchOrFocusByBundleID("com.google.Chrome.app.Default-koegeopamaoljbmhnfjbclbocehhgmkm") end)
hs.hotkey.bind({'alt'}, '3', function () hs.application.launchOrFocusByBundleID("com.google.Chrome.app.Profile-1-koegeopamaoljbmhnfjbclbocehhgmkm") end)
hs.hotkey.bind({'alt'}, '4', function () hs.application.launchOrFocusByBundleID("com.culturedcode.ThingsMac") end)
hs.hotkey.bind({'ctrl', 'shift'}, 'escape', function () hs.application.launchOrFocus("Activity Monitor") end)
hs.hotkey.bind({'alt'}, 'e', function () hs.application.launchOrFocus("Finder") end)
hs.hotkey.bind({'alt'}, 'w', function () hs.application.launchOrFocus("Visual Studio Code") end)
hs.hotkey.bind({'alt'}, 'q', function () hs.application.launchOrFocus("Telegram") end)
-- hs.hotkey.bind({'alt'}, 'v', function () hs.application.launchOrFocusByBundleID("org.vim.MacVim") end)


-- utils
-- hs.hotkey.bind({'cmd'}, 'j', function () hs.eventtap.keyStroke({}, "down") end)

-- Mouse modal keyboard shortcut environment
local mouseModal = hs.hotkey.modal.new()
function toggleMouseModal()
  if mouseModalEntered then
    mouseModal:exit()
  else
    mouseModal:enter()
  end
end
toggleMouseModal()
function mouseModal:entered()
  mouseModalEntered = true
  hs.alert.show('Enter mouse mode')
end
function mouseModal:exited()
  mouseModalEntered = false
  hs.alert.show('Exit mouse mode')
end


function scrollLine(x, y)
  return function ()
    hs.eventtap.event.newScrollEvent({x, y}, {}, 'line'):post()
  end
end
mouseModal:bind({'cmd'}, 'j', scrollLine(0, -6), nil, scrollLine(0, -6)) -- scroll down
mouseModal:bind({'cmd'}, 'k', scrollLine(0, 6), nil, scrollLine(0, 6)) -- scroll up
hs.hotkey.bind({'alt', 'cmd'}, '\\', toggleMouseModal )



-- lock screen and start screensaver
-- hs.hotkey.bind({'alt', 'ctrl'}, 'L', function() hs.caffeinate.startScreensaver() end)
-- hs.caffeinate.lockScreen()

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

hs.hotkey.bind({'alt', 'cmd'}, '-', brightMinus)
hs.hotkey.bind({'alt', 'cmd'}, '=', brightPlus)

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


-- muteOutput() - Mute sound output on all output devices.
--
function muteOutput()
    audioDevices = hs.audiodevice.allOutputDevices()
    for i = 1, #audioDevices do
        device = audioDevices[i]
        device:setMuted(true)
    end
    hs.notify.new( {title="Hammerspoon", subTitle="Sound Muted"} ):send()
end
hs.hotkey.bind(super, 'o', muteOutput)
-- toggleMicrophoneMute() - toggle mute on the default "Input Device" (probably the microphone).
--
function toggleMicrophoneMute()
    device = hs.audiodevice.defaultInputDevice()
    local newState = not device:muted()

    local message = newState == true and "Muted microphone" or "Un-muted microphone"
    --hs.notify.new( {title="Hammerspoon", subTitle=message} ):send()
    hs.alert.show(message, 0.5)

    device:setMuted(newState) -- true/false toggles muted state
end
hs.hotkey.bind(super, 'i', toggleMicrophoneMute)

-- Do not Disturb
-- System Preferences -> keyboard shortcuts -> Turn Do Not Disturb On/Off

hs.hotkey.bind({'alt'}, 'tab', function()
  hs.hints.windowHints()
end)

----------------------------------------------------------------------------------------------------
-- Register browser tab typist: Type URL of current tab of running browser in markdown format. i.e. [title](link)
-- https://github.com/ashfinal/awesome-hammerspoon
-- Type Browser Link
-- TODO: url 要用 Shift+Enter 实现

hs.hotkey.bind({'alt'}, 'v', function()
  local safari_running = hs.application.applicationsForBundleID("com.apple.Safari")
  local chrome_running = hs.application.applicationsForBundleID("com.google.Chrome")
  if #safari_running > 0 then
    local stat, data = hs.applescript('tell application "Safari" to get {URL, name} of current tab of window 1')
    if stat then hs.eventtap.keyStrokes("[" .. data[2] .. "](" .. data[1] .. ")") end
  elseif #chrome_running > 0 then
    local stat, data = hs.applescript('tell application "Google Chrome" to get {URL, title} of active tab of window 1')
    if stat then hs.eventtap.keyStrokes("[" .. data[2] .. "](" .. data[1] .. ")") end
  end
end)

----------------------------------------------------------------------------------------------------
-- https://github.com/ashfinal/awesome-hammerspoon
-- Register Hammerspoon console
hs.hotkey.bind({'alt'}, 'z', function()
  hs.toggleConsole()
end)


--[[
----------------------------------------------------------------------------------------------------
-- resizeM modal environment
if spoon.WinWin then
    spoon.ModalMgr:new("resizeM")
    local cmodal = spoon.ModalMgr.modal_list["resizeM"]
    cmodal:bind('', 'escape', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
    cmodal:bind('', 'Q', 'Deactivate resizeM', function() spoon.ModalMgr:deactivate({"resizeM"}) end)
    cmodal:bind('', 'tab', 'Toggle Cheatsheet', function() spoon.ModalMgr:toggleCheatsheet() end)
    cmodal:bind('', 'A', 'Move Leftward', function() spoon.WinWin:stepMove("left") end, nil, function() spoon.WinWin:stepMove("left") end)
    cmodal:bind('', 'D', 'Move Rightward', function() spoon.WinWin:stepMove("right") end, nil, function() spoon.WinWin:stepMove("right") end)
    cmodal:bind('', 'W', 'Move Upward', function() spoon.WinWin:stepMove("up") end, nil, function() spoon.WinWin:stepMove("up") end)
    cmodal:bind('', 'S', 'Move Downward', function() spoon.WinWin:stepMove("down") end, nil, function() spoon.WinWin:stepMove("down") end)
    cmodal:bind('', 'H', 'Lefthalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfleft") end)
    cmodal:bind('', 'L', 'Righthalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfright") end)
    cmodal:bind('', 'K', 'Uphalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfup") end)
    cmodal:bind('', 'J', 'Downhalf of Screen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("halfdown") end)
    cmodal:bind('', 'Y', 'NorthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNW") end)
    cmodal:bind('', 'O', 'NorthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerNE") end)
    cmodal:bind('', 'U', 'SouthWest Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSW") end)
    cmodal:bind('', 'I', 'SouthEast Corner', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("cornerSE") end)
    cmodal:bind('', 'F', 'Fullscreen', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("fullscreen") end)
    cmodal:bind('', 'C', 'Center Window', function() spoon.WinWin:stash() spoon.WinWin:moveAndResize("center") end)
    cmodal:bind('', '=', 'Stretch Outward', function() spoon.WinWin:moveAndResize("expand") end, nil, function() spoon.WinWin:moveAndResize("expand") end)
    cmodal:bind('', '-', 'Shrink Inward', function() spoon.WinWin:moveAndResize("shrink") end, nil, function() spoon.WinWin:moveAndResize("shrink") end)
    cmodal:bind('shift', 'H', 'Move Leftward', function() spoon.WinWin:stepResize("left") end, nil, function() spoon.WinWin:stepResize("left") end)
    cmodal:bind('shift', 'L', 'Move Rightward', function() spoon.WinWin:stepResize("right") end, nil, function() spoon.WinWin:stepResize("right") end)
    cmodal:bind('shift', 'K', 'Move Upward', function() spoon.WinWin:stepResize("up") end, nil, function() spoon.WinWin:stepResize("up") end)
    cmodal:bind('shift', 'J', 'Move Downward', function() spoon.WinWin:stepResize("down") end, nil, function() spoon.WinWin:stepResize("down") end)
    cmodal:bind('', 'left', 'Move to Left Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("left") end)
    cmodal:bind('', 'right', 'Move to Right Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("right") end)
    cmodal:bind('', 'up', 'Move to Above Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("up") end)
    cmodal:bind('', 'down', 'Move to Below Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("down") end)
    cmodal:bind('', 'space', 'Move to Next Monitor', function() spoon.WinWin:stash() spoon.WinWin:moveToScreen("next") end)
    cmodal:bind('', '[', 'Undo Window Manipulation', function() spoon.WinWin:undo() end)
    cmodal:bind('', ']', 'Redo Window Manipulation', function() spoon.WinWin:redo() end)
    cmodal:bind('', '`', 'Center Cursor', function() spoon.WinWin:centerCursor() end)

    -- Register resizeM with modal supervisor
    hsresizeM_keys = hsresizeM_keys or {"alt", "R"}
    if string.len(hsresizeM_keys[2]) > 0 then
        spoon.ModalMgr.supervisor:bind(hsresizeM_keys[1], hsresizeM_keys[2], "Enter resizeM Environment", function()
            -- Deactivate some modal environments or not before activating a new one
            spoon.ModalMgr:deactivateAll()
            -- Show an status indicator so we know we're in some modal environment now
            spoon.ModalMgr:activate({"resizeM"}, "#B22222")
        end)
    end
end

--]]

-- TODO hold cmd and move window by mouse
-- TODO change sound vol
-- TODO move app to another desktop
-- TODO move app to another screen display
-- TODO funcstion list

