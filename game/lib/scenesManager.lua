local constants = require("constants")

ScenesManager = {}
ScenesManager.__index = ScenesManager

function ScenesManager:new()
    local properties = {
        scene = constants.SCENES_TITLE,  -- Stato iniziale
        fromScene = "",   -- Valorizzato se si richiama la scena constants.SCENES_TITLE da un'altra scena
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
    self.fromScene = self.scene
    if (newScene == constants.SCENES_TITLE) then
      self.rebuildMenu = true
    end
    self.scene = newScene
end

return ScenesManager
