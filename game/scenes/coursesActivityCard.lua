local constants = require("constants")
coursesActivityCard = {}
local currentCourseGame = {
  course = false,
  courseSchedule = ""
}
local cardArea = {}
local nameArea = {}
local descriptionArea = {}
local scheduleArea = {}

--local player = yearbook.getCurrentStudent()

function coursesActivityCard.load()
  mouse.registerHandler(coursesActivityCard, constants.SCENES_COURSES_ACTIVITY_CARD)
  cardArea = screenManager:calcAreaSizes({ xPerc = 0.31, yPerc = 0.375, widthPerc = 0.38, heightPerc = 0.34 })
  nameArea = screenManager:calcAreaSizes({ xPerc = 0.445, yPerc = 0.44, widthPerc = 0.18, heightPerc = 0.05 })
  descriptionArea = screenManager:calcAreaSizes({ xPerc = 0.395, yPerc = 0.57, widthPerc = 0.28, heightPerc = 0.05 })
  scheduleArea = screenManager:calcAreaSizes({ xPerc = 0.395, yPerc = 0.63, widthPerc = 0.28, heightPerc = 0.05 })
end

function coursesActivityCard.update(dt)
  currentCourseGame.course = GameManager:getActivity(currentCourse.name)
  if currentCourseGame.course ~= false then
    currentCourseGame.courseSchedule = currentCourseGame.course:getStrSchedule()
  end
end

function coursesActivityCard.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_COURSES, false)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function coursesActivityCard.mousePressed(x, y, button)
  if screenManager:checkIfClickingOutside(x,y,cardArea) then
    scenesManager:setScene(constants.SCENES_COURSES, false)
  end
end

function coursesActivityCard.draw()

  love.graphics.setFont(constants.FONTS_NICE_CHALK_TITLE)
  screenManager:drawSceneBackground(constants.IMAGES_CS_ACTIVITY_CARD_BG)

  love.graphics.setColor(1, 0, 0)
  --love.graphics.rectangle("line",cardArea.x,cardArea.y,cardArea.width,cardArea.height)
  love.graphics.setColor(1, 1, 1)

  love.graphics.setColor(0, 0, 0)
  --love.graphics.rectangle("line", nameArea.x, nameArea.y, nameArea.width, nameArea.height)
  love.graphics.printf(currentCourse.name, nameArea.x, nameArea.y, nameArea.width, "center")
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(constants.FONTS_NICE_CHALK_BODY)

  love.graphics.setColor(0, 0, 0)
  --love.graphics.rectangle("line", descriptionArea.x, descriptionArea.y, descriptionArea.width, descriptionArea.height)
  love.graphics.printf(currentCourse.description, descriptionArea.x, descriptionArea.y, descriptionArea.width,"left")
  love.graphics.setColor(1, 1, 1)

  love.graphics.setColor(0, 0, 0)
  --love.graphics.rectangle("line", scheduleArea.x, scheduleArea.y, scheduleArea.width, scheduleArea.height)
  love.graphics.printf(currentCourseGame.courseSchedule, scheduleArea.x, scheduleArea.y, scheduleArea.width,"left")
  love.graphics.setColor(1, 1, 1)
end

return coursesActivityCard
