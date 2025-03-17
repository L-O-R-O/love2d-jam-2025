local constants = require("constants")

ScenesManager = {}
ScenesManager.__index = ScenesManager

function ScenesManager:new()
    local properties = {
      scene = constants.SCENES_TITLE,  -- Initial state
      fromScene = "",                  -- Tracks previous scene
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
    screenManager:startTransition(newScene)
end

return ScenesManager
