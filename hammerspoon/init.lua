--[[ pressing the vim-style keys hjkl moves the current window
     to the left half, lower half, top half, or right half (resp.) ]]

--[[ function factory that takes the multipliers of screen width
and height to produce the window's x pos, y pos, width, and height ]]
function baseMove(x, y, w, h)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        f.x = max.w * x
        f.y = max.h * y
        f.w = max.w * w
        f.h = max.h * h
        win:setFrame(f, 0)
    end
end
hs.hotkey.bind({'alt', 'cmd'}, 'H', baseMove(0, 0, 0.5, 1))
hs.hotkey.bind({'alt', 'cmd'}, 'L', baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind({'alt', 'cmd'}, 'J', baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind({'alt', 'cmd'}, 'K', baseMove(0, 0, 1, 0.5))
