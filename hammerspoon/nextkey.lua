-- Simple Key bindings

-- Normal mode {{{1

local normal = hs.hotkey.modal.new()

-- Enter & Exit mode {{{2
-- <c-[> - enter Normal mode
-- I don't remap <esc> because it's too risky
enterNormal = hs.hotkey.bind({"ctrl", "shift"}, "[", function()
    normal:enter()
end)
function normal:entered() hs.alert.show('Enter (Next Mode)') end

-- <esc> - exit Normal mode
normal:bind({}, 'escape', function()
    normal:exit()
    hs.alert.show('Exit (Next Mode)')
end)
-- }}}2

-- Movements

-- h - move left
function left() hs.eventtap.keyStroke({}, "Left") end
normal:bind({}, 'h', left, nil, left)

-- l - move right {{{3
function right() hs.eventtap.keyStroke({}, "Right") end
normal:bind({}, 'l', right, nil, right)

-- k - move up {{{3
function up() hs.eventtap.keyStroke({}, "Up") end
normal:bind({}, 'k', up, nil, up)

-- j - move down {{{3
function down() hs.eventtap.keyStroke({}, "Down") end
normal:bind({}, 'j', down, nil, down)

-- Next Key index
dict = {
  scrollDown = function() hs.eventtap.scrollWheel({0, 40}, {}, 'line') end,
  scrollUp = function() hs.eventtap.scrollWheel({0, -40}, {}, 'line') end,
  right = function() hs.eventtap.keyStroke({}, "right") end,
}

-- Space
nextType = 'scrollDown'
normal:bind({}, 'space', function() dict[nextType]() end, nil, nil)
normal:bind({"shift"}, 'space', function() dict["scrollUp"]() end, nil, nil)

-- More Info
normal:bind({}, '1', function() nextType = 'scrollDown' end, nil, nil)
normal:bind({}, '2', function() nextType = 'scrollUp' end, nil, nil)
normal:bind({}, '3', function() nextType = 'right' end, nil, nil)

