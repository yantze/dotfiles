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

--{{{ Config

super = {"ctrl", "alt", "cmd"}

function reloadConfig(files) -- `files` available in pathwatcher
  hs.reload()
  hs.notify.new({title="Hammerspoon config reloaded", informativeText="By user operation"}):send()
  -- hs.alert.show("loaded")
end
hs.hotkey.bind(super, "R", reloadConfig)
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

--}}}

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

-- hs.hotkey.bind({'alt'}, 'tab', function()
--   hs.hints.windowHints()
-- end)


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
    hs.timer.doAfter(1, function ()
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
