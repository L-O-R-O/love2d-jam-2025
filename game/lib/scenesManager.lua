ScenesManager = {}
ScenesManager.__index = ScenesManager

function ScenesManager:new()
    local properties = {
        state = "title",  -- Stato iniziale
    }
    setmetatable(properties, ScenesManager)
    return properties
end

-- Cambiare stato del gioco
function ScenesManager:getState()
    return self.state
end

function ScenesManager:setState(newState)
    self.state = newState
end

return ScenesManager
