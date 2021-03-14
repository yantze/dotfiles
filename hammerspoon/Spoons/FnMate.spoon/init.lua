--- === FnMate ===
---
--- Use Fn + `h/l/j/k` as arrow keys, `y/u/i/o` as mouse wheel, `,/.` as left/right click.
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/FnMate.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/FnMate.spoon.zip)

local obj={}
obj.__index = obj

-- Metadata
obj.name = "FnMate"
obj.version = "1.0"
obj.author = "ashfinal <ashfinal@gmail.com>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
    local function catcher(event)
        if event:getFlags()['fn'] and event:getFlags()['cmd'] and event:getCharacters() == "j" then
            return true, {hs.eventtap.event.newKeyEvent({"cmd"}, "down", true)}
        elseif event:getFlags()['fn'] and event:getFlags()['cmd'] and event:getCharacters() == "k" then
            return true, {hs.eventtap.event.newKeyEvent({"cmd"}, "up", true)}
        elseif event:getFlags()['fn'] and event:getFlags()['cmd'] and event:getCharacters() == "h" then
            return true, {hs.eventtap.event.newKeyEvent({"cmd"}, "left", true)}
        elseif event:getFlags()['fn'] and event:getFlags()['cmd'] and event:getCharacters() == "l" then
            return true, {hs.eventtap.event.newKeyEvent({"cmd"}, "right", true)}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "h" then
        --     return true, {hs.eventtap.event.newKeyEvent({}, "left", true)}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "l" then
        --     return true, {hs.eventtap.event.newKeyEvent({}, "right", true)}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "j" then
        --     return true, {hs.eventtap.event.newKeyEvent({}, "down", true)}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "k" then
            -- hs.alert.show("cmd:" .. tostring(event:getFlags()['cmd']), 0.5)
            -- hs.alert.show("alt:" .. tostring(event:getFlags()['alt']), 0.5)
            -- hs.alert.show("shift:" .. tostring(event:getFlags()['shift']), 0.5)
            -- hs.alert.show("ctrl:" .. tostring(event:getFlags()['ctrl']), 0.5)
            -- return true, {hs.eventtap.event.newKeyEvent({}, "up", true)}

        -- elseif event:getFlags()['fn'] and event:getKeyCode() == hs.keycodes.map['Lfet'] then
            -- hs.alert.show(hs.inspect(event:getKeyCode()))
            -- hs.alert.show(hs.inspect(hs.keycodes.map['Lfet']))
            -- return true, {hs.eventtap.event.newKeyEvent({"cmd"}, "up", true)}

        -- elseif event:getFlags()['fn'] and event:getFlags()['shift'] and event:getCharacters() == "n" then
        --     return true, {hs.eventtap.event.newKeyEvent({'shift'}, "down", true)}

        -- elseif event:getFlags()['fn'] and event:getCharacters() == "n" then
        --     return true, {hs.eventtap.event.newKeyEvent({}, "down", true)}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "p" then
        --     return true, {hs.eventtap.event.newKeyEvent({}, "up", true)}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "y" then
        --     return true, {hs.eventtap.event.newScrollEvent({10, 0}, {}, "line")}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "o" then
        --     return true, {hs.eventtap.event.newScrollEvent({-10, 0}, {}, "line")}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "u" then
        --     return true, {hs.eventtap.event.newScrollEvent({0, -10}, {}, "line")}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "i" then
        --     return true, {hs.eventtap.event.newScrollEvent({0, 10}, {}, "line")}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "," then
        --     local currentpos = hs.mouse.getAbsolutePosition()
        --     return true, {hs.eventtap.leftClick(currentpos)}
        -- elseif event:getFlags()['fn'] and event:getCharacters() == "." then
        --     local currentpos = hs.mouse.getAbsolutePosition()
        --     return true, {hs.eventtap.rightClick(currentpos)}

        -- Functions Key
        -- elseif event:getFlags()['fn'] then
        --     hs.alert.show(hs.inspect(event:getKeyCode()))
        --     return true, { changeVolume(-3) }
        elseif event:getFlags()['fn'] and event:getKeyCode() == 115 then -- Fn + Left
            return true, { changeVolume(-3) }
        elseif event:getFlags()['fn'] and event:getKeyCode() == 119 then -- Fn + Right
            return true, { changeVolume(3) }
        elseif event:getFlags()['fn'] and event:getKeyCode() == 116 then -- Fn + Up
            return true, { changeBright(5) }
        elseif event:getFlags()['fn'] and event:getKeyCode() == 121 then -- Fn + Down
            return true, { changeBright(-5) }
        end
    end
    fn_tapper = hs.eventtap.new({hs.eventtap.event.types.keyDown}, catcher):start()
end


function changeVolume(diff)
    local current = hs.audiodevice.defaultOutputDevice():volume()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    if new > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    end
    hs.alert.closeAll(0.0)
    hs.alert.show("Volume " .. new .. "%", {}, 0.5)
    hs.audiodevice.defaultOutputDevice():setVolume(new)
end

function changeBright(diff)
  local current = hs.brightness.get()
  local bright = current + diff
  if (bright > 100) then
    hs.brightness.set(100)
  elseif (bright <= 0) then
    hs.brightness.set(0)
  else
    hs.brightness.set(bright)
  end
end

return obj

