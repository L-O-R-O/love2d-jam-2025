local constants = require("constants")

agenda = {}

function agenda.load()
  mouse.registerHandler(agenda, constants.SCENES_AGENDA)
end

function agenda.update(dt)

end

function agenda.draw()
  screenManager:drawSceneBackground(constants.IMAGES_AGENDA_BG)
end

function agenda.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function agenda.mousePressed(x, y, button)
  print('AGENDA mousepressed')
end

function agenda.mouseHovered(x, y)
  -- print('AGENDA mousehovered')
end

return agenda
