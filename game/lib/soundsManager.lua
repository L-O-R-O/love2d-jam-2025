local constants = require("constants")

SoundsManager = {}
SoundsManager.__index = SoundsManager

function SoundsManager:new()
  local properties = {

  }
  setmetatable(properties, SoundsManager)
  return properties
end

function SoundsManager:playSceneTransitionSound(fromScene,toScene)
  local sound = nil
  if fromScene == constants.SCENES_DESKTOP then
    if toScene == constants.SCENES_YEARBOOK or toScene == constants.SCENES_COURSES then
      sound = constants.SOUNDS_MOUSE_CLICK
    elseif toScene == constants.SCENES_AGENDA or toScene == constants.SCENES_CALENDAR then
      sound = constants.SOUNDS_PAGE_TURN
    end
  end
  if sound then
    sound:play()
  end
end

return SoundsManager
