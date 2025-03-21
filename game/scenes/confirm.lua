local constants = require("constants")

confirm = {}

function confirm.load()
  mouse.registerHandler(agenda, constants.SCENES_CONFIRM)
end

function confirm.update(dt)
end

function confirm.draw()
  -- screenManager:drawSceneBackground(constants.IMAGES_OUTCOME_WIN_SESSION)
end

function confirm.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function confirm.mousePressed(x, y, button)
end

function confirm.mouseHovered(x, y)
end

return confirm
