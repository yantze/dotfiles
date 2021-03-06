
-- http://github.com/dbmrq/dotfiles/

-- Keep holding Cmd-Q to close apps, so you don't do it accidentally.

-- Replaces apps like CommandQ and SlowQuitApps.

pressedQTime = 0

function pressedQ()
    hs.alert.show("⌘Q")
    pressedQTime = os.time()
end

function releasedQ()
    hs.alert.closeAll()
end

function repeatQ()
    if pressedQTime > 0 and os.time() - pressedQTime > 0 then
        pressedQTime = 0
        hs.application.frontmostApplication():kill()
        hs.alert.closeAll()
    end
end

hs.hotkey.bind('cmd', 'Q', pressedQ, releasedQ, repeatQ)

