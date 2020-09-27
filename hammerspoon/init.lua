-- Basic extension {{{
-- require 'clipboard'
-- require 'slowq'
require 'nextkey'
-- local vimouse = require('vimouse')
-- vimouse('cmd', 'm')

-- Define default Spoons which will be loaded later
if not hspoon_list then
    hspoon_list = {
        -- "ClipShow",
        -- "WinWin",
        "FnMate",
        -- "UnsplashZ"
    }
end

-- Load those Spoons
for _, v in pairs(hspoon_list) do
    hs.loadSpoon(v)
end

local logger = hs.logger.new("User", 5)

-- }}}

-- Resize windows {{{

hs.window.animationDuration = 0 -- disable animations
hs.grid.setMargins({0, 0})
--[[ function factory that takes the multipliers of screen width
and height to produce the window's x pos, y pos, width, and height ]]
function baseMove(x, y, w, h)
-- s:currentMode().scale

    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        -- 如果是高分屏，偏移位置不一样
        local hidpi = screen:currentMode().scale == 2.0

        -- add max.x so it stays on the same screen, works with my second screen
        f.x = max.w * x + max.x + (hidpi and 4 or 2)
        f.y = max.h * y + max.y
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
hs.hotkey.bind(super, 'Up', baseMove(0, 0, 1, 0.84))

hs.hotkey.bind(super, 'M', hs.grid.maximizeWindow)
hs.hotkey.bind(super, 'C', baseMove(0.25, 0.25, 0.5, 0.5))

hs.hotkey.bind({'ctrl', 'cmd'}, 'Left', baseMove(0, 0, 1/3, 1))
hs.hotkey.bind({'ctrl', 'cmd'}, 'Right', baseMove(2/3, 0, 1/3, 1))
hs.hotkey.bind({'alt', 'shift', 'cmd'}, 'Left', baseMove(0, 0, 2/3, 1))
hs.hotkey.bind({'alt', 'shift', 'cmd'}, 'Right', baseMove(1/3, 0, 2/3, 1))

-- }}}

--{{{ Reload config
--[[

function reloadConfig(files) -- `files` available in pathwatcher
  hs.reload()
  hs.notify.new({title="Hammerspoon config reloaded", informativeText="By user operation"}):send()
  -- hs.alert.show("loaded")
end
hs.hotkey.bind(super, "R", reloadConfig)
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

}}} --]]

-- Quick jump to applications {{{
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
-- hs.hotkey.bind({'alt'}, '3', function () hs.application.launchOrFocusByBundleID("com.google.Chrome.app.Profile-1-koegeopamaoljbmhnfjbclbocehhgmkm") end)
hs.hotkey.bind({'alt'}, '3', function () hs.application.launchOrFocusByBundleID("com.workflowy.desktop") end)
hs.hotkey.bind({'alt'}, '4', function ()
  hs.application.launchOrFocusByBundleID("com.culturedcode.ThingsMac")
  -- Show all window when Things is actived
  -- local windows = hs.application.find("Things"):findWindow("")
  -- logger:w('--------------------:', windows)
  -- for i = 1, #windows do
  --   logger:w('--------------------:', windows[i])
  --   windows[i]:focus()
  -- end

end)
hs.hotkey.bind({'ctrl', 'shift'}, 'escape', function () hs.application.launchOrFocus("Activity Monitor") end)
hs.hotkey.bind({'alt'}, 'e', function () hs.application.launchOrFocus("Finder") end)
hs.hotkey.bind({'alt'}, 'w', function () hs.application.launchOrFocus("Visual Studio Code") end)
-- hs.hotkey.bind({'alt'}, 'w', function () hs.application.launchOrFocus("Visual Studio Code - Insiders") end)
hs.hotkey.bind({'alt'}, 'q', function () hs.application.launchOrFocus("Telegram") end)
hs.hotkey.bind({'cmd', 'shift'}, '0', function () hs.application.launchOrFocus("DevDocs") end)
-- hs.hotkey.bind({'alt'}, 'v', function () hs.application.launchOrFocusByBundleID("org.vim.MacVim") end)

-- }}}

-- [[ {{{

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
-- mouseModal:bind({'cmd'}, 'j', scrollLine(0, -6), nil, scrollLine(0, -6)) -- scroll down
-- mouseModal:bind({'cmd'}, 'k', scrollLine(0, 6), nil, scrollLine(0, 6)) -- scroll up
mouseModal:bind({}, 'j', scrollLine(0, -6), nil, scrollLine(0, -6)) -- scroll down
mouseModal:bind({}, 'k', scrollLine(0, 6), nil, scrollLine(0, 6)) -- scroll up
mouseModal:bind({}, 'space', scrollLine(0, -6), nil, scrollLine(0, -6)) -- scroll down
mouseModal:bind({}, 'i', toggleMouseModal)
hs.hotkey.bind({'alt', 'cmd'}, '\\', toggleMouseModal )

-- ]] }}}

-- utils {{{
-- hs.hotkey.bind({'cmd'}, 'j', function () hs.eventtap.keyStroke({}, "down") end)

-- lock screen and start screensaver
-- hs.hotkey.bind({'alt', 'ctrl'}, 'L', function() hs.caffeinate.startScreensaver() end)
-- hs.caffeinate.lockScreen()

-- sleep system immediately
hs.hotkey.bind({'alt', 'cmd'}, 'f15', function() hs.caffeinate.systemSleep() end)

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

-- TODO force quit app
-- hs

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
-- Type Browser Link
-- Change from https://github.com/ashfinal/awesome-hammerspoon

hs.hotkey.bind({'alt'}, 'i', function()
  -- local safari_running = hs.application.applicationsForBundleID("com.apple.Safari")
  local chrome_running = hs.application.applicationsForBundleID("com.google.Chrome")
  local stat, data
  -- if #safari_running > 0 then
  --   stat, data = hs.applescript('tell application "Safari" to get {URL, name} of current tab of window 1')
  -- elseif #chrome_running > 0 then
  if #chrome_running > 0 then
    stat, data = hs.applescript('tell application "Google Chrome" to get {URL, title} of active tab of window 1')
  end

  if stat then
    hs.eventtap.keyStrokes(data[2])
    hs.timer.doAfter(0.8, function ()
        hs.eventtap.keyStroke({"shift"}, "return")
        hs.eventtap.keyStrokes(data[1])
    end)
  end
end)

----------------------------------------------------------------------------------------------------
-- Type remote clipboard

hs.hotkey.bind({'alt'}, 'v', function () hs.eventtap.keyStrokes(hs.execute('/usr/local/bin/pan clipboard __GET__')) end)
hs.hotkey.bind({'alt'}, 'c', function ()
  hs.execute('echo "' .. hs.pasteboard.readString() .. '" | /usr/local/bin/pan clipboard')
end)


----------------------------------------------------------------------------------------------------
-- https://github.com/ashfinal/awesome-hammerspoon
-- Register Hammerspoon console
hs.hotkey.bind({'alt'}, 'z', function()
  hs.toggleConsole()
end)

--[[
----------------------------------------------------------------------------------------------------
-- check mac awake and sleep
function sleepWatch(eventType)
  if (eventType == hs.caffeinate.watcher.systemWillSleep) then
    hs.alert.show("Going to sleep!")
  elseif (eventType == hs.caffeinate.watcher.systemDidWake) then
    hs.alert.show("Waking up!")
  end
end

local sleepWatcher = hs.caffeinate.watcher.new(sleepWatch)
sleepWatcher:start()
----------------------------------------------------------------------------------------------------
--]]

-- }}}

--[[ {{{
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

}}} --]]

--[[ {{{
----------------------------------------------------------------------------------------------------
-- https://gist.github.com/kizzx2/e542fa74b80b7563045a
-- Inspired by Linux alt-drag or Better Touch Tools move/resize functionality

function get_window_under_mouse()
  -- Invoke `hs.application` because `hs.window.orderedWindows()` doesn't do it
  -- and breaks itself
  local _ = hs.application

  local my_pos = hs.geometry.new(hs.mouse.getAbsolutePosition())
  local my_screen = hs.mouse.getCurrentScreen()

  return hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return my_screen == w:screen() and my_pos:inside(w:frame())
  end)
end

dragging_win = nil
dragging_mode = 1

drag_event = hs.eventtap.new({ hs.eventtap.event.types.mouseMoved }, function(e)
  if dragging_win then
    local dx = e:getProperty(hs.eventtap.event.properties.mouseEventDeltaX)
    local dy = e:getProperty(hs.eventtap.event.properties.mouseEventDeltaY)
    local mods = hs.eventtap.checkKeyboardModifiers()

    -- Ctrl + Shift to move the window under cursor
    -- if dragging_mode == 1 and mods.ctrl and mods.shift then
    if dragging_mode == 1 and mods.alt then
      dragging_win:move({dx, dy}, nil, false, 0)

    -- Alt + Shift to resize the window under cursor
    -- elseif mods.alt and mods.shift then
    elseif mods.alt then
      local sz = dragging_win:size()
      local w1 = sz.w + dx
      local h1 = sz.h + dy
      dragging_win:setSize(w1, h1)
    end
  end
  return nil
end)

flags_event = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
  local flags = e:getFlags()
  -- if flags.ctrl and flags.shift and dragging_win == nil then
  if flags.cmd and dragging_win == nil then
    dragging_win = get_window_under_mouse()
    dragging_mode = 1
    drag_event:start()
  elseif flags.cmd and dragging_win == nil then
    dragging_win = get_window_under_mouse()
    dragging_mode = 2
    drag_event:start()
  else
    drag_event:stop()
    dragging_win = nil
  end
  return nil
end)
flags_event:start()

----------------------------------------------------------------------------------------------------
}}} --]]

--[[ {{{
-- Circle mouse pointer on CMD+ALT+SHIFT+D
-- https://gist.github.com/dropmeaword/ddf7b5b3a0e81ef1142f446f3f91075a
-- invalid code
local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()

    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end
hs.hotkey.bind({"cmd","alt","shift"}, "D", mouseHighlight)

----------------------------------------------------------------------------------------------------
}}} --]]

--[[ {{{ Study hammerspoon
-- timer
hs.timer.doAfter(3, function()
  print('print after 3s.')
end):start()

-- manipulate menu
--   for k, v in pairs( hs.window.visibleWindows() ) do
--    print(k, v)
--   end
--   print('==============================')

--   -- check if application activate event (vs. close?)
--   if (eventType == hs.application.watcher.activated) then
--       hs.alert.show(appName)
--       if (appName == "Finder") then
--         --Bring all Finder windows forward when one gets activated
--         appObject:selectMenuItem({"Window", "Bring All to Front"})
--       end
--   end
--
-- Ref:
-- https://github.com/KyleKing/My_Local_Hammerspoon/blob/91e18aefb762aabd1886ec8fb8540e8f4d1a98cb/Other/z_untracked.lua
--]]

-- TODO move app to another desktop
-- from: https://github.com/Hammerspoon/hammerspoon/issues/235
-- TODO move app to another screen display
-- }}}

-- vim: set ts=4 sw=4 tw=0 et fdm=marker foldmarker={{{,}}} foldlevel=0 foldenable foldlevelstart=99 :
