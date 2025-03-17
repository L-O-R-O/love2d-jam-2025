local constants = require("constants")

computer = {}

function computer.load()
  mouse.registerHandler(computer, constants.SCENES_COMPUTER)
end

function computer.update(dt)

end

function computer.draw()
  screenManager:drawSceneBackground(constants.IMAGES_COMPUTER_BG)
end

function computer.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function computer.mousePressed(x, y, button)
  print('COMPUTER mousepressed')
end

function computer.mouseHovered(x, y)
  -- print('COMPUTER mousehovered')
end

return computer
