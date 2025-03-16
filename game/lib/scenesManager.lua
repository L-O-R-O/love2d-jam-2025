ScenesManager = {}
ScenesManager.__index = ScenesManager

function ScenesManager:new()
    local properties = {
        scene = "title",  -- Stato iniziale
        fromScene = "",   -- Valorizzato se si richiama la scena "title" da un'altra scena
        rebuildMenu = false
    }
    setmetatable(properties, ScenesManager)
    return properties
end

-- Cambiare stato del gioco
function ScenesManager:getScene()
    return self.scene
end

function ScenesManager:setScene(newScene)
    self.scene = newScene
end

return ScenesManager
