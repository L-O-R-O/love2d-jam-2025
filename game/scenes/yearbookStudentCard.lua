local constants = require("constants")

yearbookStudentCard = {}
local studentCardArea = {}
local imageArea = {}
local nameArea = {}
local quoteArea = {}
local bestMemoryArea = {}
local activitiesArea = {}
--local player = yearbook.getCurrentStudent()

local function setFont(font, size)
  love.graphics.setFont(font, size)
end

function yearbookStudentCard.load()
  mouse.registerHandler(yearbookStudentCard, constants.SCENES_YEARBOOK_STUDENT_CARD)
  yearbookStudentCard.setAreas()
end

function yearbookStudentCard.setAreas()
  -- Define the main card area first
  studentCardArea = {
    x = 650,
    y = 430,
    width = 600,
    height = 400,
  }
  -- Calculate image area
  imageArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.1,
    yPerc = 0.10,
    widthPerc = 0.35,
    heightPerc = 0.5,
  })
  nameArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.49,
    yPerc = 0.11,
    widthPerc = 0.45,
    heightPerc = 0.1,
  })
  -- Calculate description area relative to the card
  quoteArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.48,
    yPerc = 0.25,
    widthPerc = 0.49,
    heightPerc = 0.24,
  })
  bestMemoryArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.48,
    yPerc = 0.25,
    widthPerc = 0.49,
    heightPerc = 0.12,
  })
  bestMemoryArea.y = quoteArea.y + quoteArea.height + 5
  activitiesArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.15,
    yPerc = 0.7,
    widthPerc = 0.85,
    heightPerc = 0.3,
  })
end

function yearbookStudentCard.update(dt) end

function yearbookStudentCard.keypressed(key)
  if key == constants.KEYS_ESCAPE_MENU then
    scenesManager:setScene(constants.SCENES_YEARBOOK, false)
  elseif key == "c" then
    scenesManager:setScene(constants.SCENES_CALENDAR)
  elseif key == "f" then
    scenesManager:setScene(constants.SCENES_COURSES)
  elseif key == "j" then
    scenesManager:setScene(constants.SCENES_AGENDA)
  elseif key == "d" then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif key == "p" then
    scenesManager:setScene(constants.SCENES_TITLE)
  elseif key == "l" then
    yearbookStudentCard.setAreas()
  end
end

function yearbookStudentCard.mousePressed(x, y, button)
  print("yearbookStudentCard clicked x:" .. x .. " and y:" .. y)
  if screenManager:checkIfClickingOutside(x,y,studentCardArea) then
    scenesManager:setScene(constants.SCENES_YEARBOOK, false)
  end
end

function yearbookStudentCard.draw()
  local debugColor = { 0, 1, 0 }
  screenManager:drawSceneBackground(constants.IMAGES_YB_STUDENT_CARD_BG)

  yearbookStudentCard.setAreas()

  -- Draw card boundaries
  love.graphics.setColor(debugColor)
  --love.graphics.rectangle("line", studentCardArea.x, studentCardArea.y, studentCardArea.width, studentCardArea.height)

  -- Draw image area
  if (currentStudent.image ~= nil and currentStudent.image ~= "") then
    love.graphics.setColor(1, 1, 1)
    local image = currentStudent.image
    image:setFilter("linear", "linear")
    love.graphics.draw(image, imageArea.x, imageArea.y, 0,0.18,0.18)
  end
  --love.graphics.rectangle("line", imageArea.x, imageArea.y, imageArea.width, imageArea.height)

  -- Draw name area
  --love.graphics.rectangle("line", nameArea.x, nameArea.y, nameArea.width, nameArea.height)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(constants.FONTS_NICE_CHALK_TITLE)
  love.graphics.printf(currentStudent.name, nameArea.x, nameArea.y, nameArea.width, "center", -0.03)

  -- Draw quote area
  love.graphics.setColor(debugColor)
  --love.graphics.rectangle("line", quoteArea.x, quoteArea.y, quoteArea.width, quoteArea.height)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(constants.FONTS_NICE_CHALK_BODY)
  love.graphics.printf('"'..currentStudent.quote..'"', quoteArea.x, quoteArea.y, quoteArea.width, "center", -0.02)
  love.graphics.setColor(1, 1, 1)

  -- Draw bestMemory area
  love.graphics.setColor(debugColor)
  --love.graphics.rectangle("line", bestMemoryArea.x, bestMemoryArea.y, bestMemoryArea.width, bestMemoryArea.height)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(constants.FONTS_NICE_CHALK_BODY)
  love.graphics.printf("Best Memory: "..currentStudent.bestMemory, bestMemoryArea.x, bestMemoryArea.y, bestMemoryArea.width, "left", -0.015)
  love.graphics.setColor(1, 1, 1)

  -- Draw activities area
  love.graphics.setColor(debugColor)
  --love.graphics.rectangle("line", activitiesArea.x, activitiesArea.y, activitiesArea.width, activitiesArea.height)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setColor(1, 1, 1)
  --[[   for index, activity in ipairs(currentStudent.activities) do
    local yOffset = 0.67 + (index - 1) * 0.033
    local tab = screenManager:calcAreaSizes({ xPerc = 0.395, yPerc = yOffset, widthPerc = 0.8, heightPerc = 0.1 })
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(activity.name, tab.x, tab.y, tab.width)
    love.graphics.setColor(1, 1, 1)
  end ]]
end


return yearbookStudentCard
