local constants = require("constants")

yearbookStudentCard = {}

--local player = yearbook.getCurrentStudent()

function yearbookStudentCard.load()
  mouse.registerHandler(yearbookStudentCard, constants.SCENES_YEARBOOK_STUDENT_CARD)
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
  end
end

function yearbookStudentCard.mousePressed(x, y, button)
  print("yearbookStudentCard clicked x:" .. x .. " and y:" .. y)
end

function yearbookStudentCard.draw()
  local debugColor = { 0, 1, 0 }
  --constants.setFont(constants.FONTS_NICE_CHALK, 30)
  screenManager:drawSceneBackground(constants.IMAGES_YB_STUDENT_CARD_BG)

  -- Define the main card area first
  local studentCardArea = {
    x = 650,
    y = 430,
    width = 600,
    height = 400,
  }
  -- Draw card boundaries
  love.graphics.setColor(debugColor)
  love.graphics.rectangle("line", studentCardArea.x, studentCardArea.y, studentCardArea.width, studentCardArea.height)

  -- Calculate image area
  local imageArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.10, -- 10% from card's left edge
    yPerc = 0.10, -- 10% from card's top
    widthPerc = 0.35, -- 30% of card's width
    heightPerc = 0.5, -- 80% of card's height
  })
  love.graphics.rectangle("line", imageArea.x, imageArea.y, imageArea.width, imageArea.height)

  -- Calculate other elements relative to the card area
  local nameArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.5, -- 10% from card's left edge
    yPerc = 0.1, -- 10% from card's top
    widthPerc = 0.45, -- 80% of card's width
    heightPerc = 0.1, -- 10% of card's height
  })

  -- Draw name area
  love.graphics.rectangle("line", nameArea.x, nameArea.y, nameArea.width, nameArea.height)
  love.graphics.setColor(0, 0, 0)
  setFont(constants.FONTS_NICE_CHALK_ONLY_FONT, 35)
  love.graphics.printf(currentStudent.name, nameArea.x, nameArea.y, nameArea.width, "left")

  -- Calculate description area relative to the card
  local descriptionArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.5,
    yPerc = 0.25,
    widthPerc = 0.5,
    heightPerc = 0.3,
  })

  -- Draw description area
  love.graphics.setColor(debugColor)
  love.graphics.rectangle("line", descriptionArea.x, descriptionArea.y, descriptionArea.width, descriptionArea.height)
  love.graphics.setColor(0, 0, 0)
  setFont(constants.FONTS_NICE_CHALK_ONLY_FONT, 15)
  love.graphics.printf(currentStudent.bestMemory, descriptionArea.x, descriptionArea.y, descriptionArea.width, "left")
  love.graphics.setColor(1, 1, 1)

  -- LISTA ATTIVITA'
  local activitiesArea = screenManager:calcRelativeArea(studentCardArea, {
    xPerc = 0.15,
    yPerc = 0.7,
    widthPerc = 0.85,
    heightPerc = 0.3,
  })
  love.graphics.setColor(debugColor)
  love.graphics.rectangle("line", activitiesArea.x, activitiesArea.y, activitiesArea.width, activitiesArea.height)
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

function setFont(font, size)
  love.graphics.setFont(font, size)
end

return yearbookStudentCard
