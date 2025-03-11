StatesManager = {}
StatesManager.__index = StatesManager

function StatesManager:new()
    local properties = {
        state = "title",  -- Stato iniziale
    }
    setmetatable(properties, StatesManager)
    return properties
end

-- Cambiare stato del gioco
function StatesManager:getState()
    return self.state
end

function StatesManager:setState(newState)
    self.state = newState
end

return StatesManager
