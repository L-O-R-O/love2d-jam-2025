local constants = require("constants")

tutorial = {}

local tutorialArea = {}

function tutorial.load()
  mouse.registerHandler(tutorial, constants.SCENES_TUTORIAL)
  tutorialArea = screenManager:calcAreaSizes({
    xPerc = 0.11,
    yPerc = 0.10,
    widthPerc = 0.77,
    heightPerc = 0.77
  })
end

function tutorial.update(dt)

end

function tutorial.draw()
  screenManager:drawSceneBackground(constants.IMAGES_TUTORIAL_BG)
--[[ love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle("line",tutorialArea.x,tutorialArea.y,tutorialArea.width,tutorialArea.height)
  ]]
  love.graphics.setColor(1, 1, 1)
end

function tutorial.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function tutorial.mousePressed(x, y, button)
  print('tutorial mousepressed')
  if screenManager:checkIfClickingOutside(x,y,tutorialArea) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  end
end

function tutorial.mouseHovered(x, y)
  -- print('tutorial mousehovered')
end

return tutorial
