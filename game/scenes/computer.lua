local constants = require("constants")
local courses = require("scenes.courses")
computer = {}

function computer.load()
  computerCurrentState = "courses"
  mouse.registerHandler(computer, constants.SCENES_COMPUTER)
end

function computer.update(dt)

end

function computer.draw()
  screenManager:drawSceneBackground(constants.IMAGES_COMPUTER_BG)
  if (computerCurrentState == "courses") then
    courses.draw()
  end
end

function computer.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  elseif (key == "y") then
    if computerCurrentState == nil then
      computerCurrentState = "courses"
    else
      computerCurrentState = nil
    end
  end
end

function computer.mousePressed(x, y, button)
  print('COMPUTER mousepressed')
end

function computer.mouseHovered(x, y)
  -- print('COMPUTER mousehovered')
end

return computer
