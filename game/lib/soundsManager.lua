local constants = require("constants")

SoundsManager = {}
SoundsManager.__index = SoundsManager

function SoundsManager:new()
  local properties = {
  }
  setmetatable(properties, SoundsManager)
  return properties
end

function SoundsManager:stopMusic()
  local music = constants.SOUNDS_BACKGROUND_MUSIC
  music:stop()
end

function SoundsManager:startMusic()
  local music = constants.SOUNDS_BACKGROUND_MUSIC
  --music:play()
  music:setLooping(true)
end

function SoundsManager:mute(audio)
  audio:setVolume(0)
end

function SoundsManager:unmute(audio)
  audio:setVolume(1)
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

function SoundsManager:playClickOnComputerScreen()
  local sound = constants.SOUNDS_MOUSE_CLICK
  sound:play()
end

return SoundsManager
