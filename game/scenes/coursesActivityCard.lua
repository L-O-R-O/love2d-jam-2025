local constants = require("constants")
local cardArea = {}
coursesActivityCard = {}

--local player = yearbook.getCurrentStudent()

function coursesActivityCard.load()
  mouse.registerHandler(coursesActivityCard, constants.SCENES_COURSES_ACTIVITY_CARD)
  cardArea = screenManager:calcAreaSizes({ xPerc = 0.31, yPerc = 0.375, widthPerc = 0.38, heightPerc = 0.34 })

end

function coursesActivityCard.update(dt)
end

function coursesActivityCard.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_COURSES, false)
  elseif (key =='c') then
    scenesManager:setScene(constants.SCENES_CALENDAR)
  elseif (key =='f') then
    scenesManager:setScene(constants.SCENES_COURSES)
  elseif (key =='j') then
    scenesManager:setScene(constants.SCENES_AGENDA)
  end
end

function coursesActivityCard.mousePressed(x, y, button)
  if screenManager:checkIfClickingOutside(x,y,cardArea) then
    scenesManager:setScene(constants.SCENES_COURSES, false)
  end
end

function coursesActivityCard.draw()
  love.graphics.setFont(constants.FONTS_NICE_CHALK)
  screenManager:drawSceneBackground(constants.IMAGES_CS_ACTIVITY_CARD_BG)

  love.graphics.setColor(1, 0, 0)
  --love.graphics.rectangle("line",cardArea.x,cardArea.y,cardArea.width,cardArea.height)
  love.graphics.setColor(1, 1, 1)

  local nameArea = screenManager:calcAreaSizes({ xPerc = 0.5, yPerc = 0.44, widthPerc = 0.8, heightPerc = 0.1 })
  love.graphics.setColor(0, 0, 0)
  love.graphics.printf(currentCourse.name, nameArea.x, nameArea.y, nameArea.width)
  love.graphics.setColor(1, 1, 1)

  local descriptionArea = screenManager:calcAreaSizes({ xPerc = 0.325, yPerc = 0.53, widthPerc = 0.35, heightPerc = 0.05 })
  love.graphics.setColor(0, 0, 0)
  --love.graphics.rectangle("line", descriptionArea.x, descriptionArea.y, descriptionArea.width, descriptionArea.height)
  love.graphics.printf(currentCourse.description, descriptionArea.x, descriptionArea.y, descriptionArea.width,"center")
  love.graphics.setColor(1, 1, 1)
end

return coursesActivityCard
