local constants = require("constants")

yearbookStudentCard = {}

--local player = yearbook.getCurrentStudent()

function yearbookStudentCard.load()
  mouse.registerHandler(yearbookStudentCard, constants.SCENES_YEARBOOK_STUDENT_CARD)
end

function yearbookStudentCard.update(dt)
end

function yearbookStudentCard.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_YEARBOOK, false)
  elseif (key =='c') then
    scenesManager:setScene(constants.SCENES_CALENDAR)
  elseif (key =='f') then
    scenesManager:setScene(constants.SCENES_COURSES)
  elseif (key =='j') then
    scenesManager:setScene(constants.SCENES_AGENDA)
  end
end

function yearbookStudentCard.mousePressed(x, y, button)
end

function yearbookStudentCard.draw()
  --constants.setFont(constants.FONTS_NICE_CHALK, 30)
  screenManager:drawSceneBackground(constants.IMAGES_YB_STUDENT_CARD_BG)
  -- NOME
  local nameArea = screenManager:calcAreaSizes({ xPerc = 0.5, yPerc = 0.44, widthPerc = 0.8, heightPerc = 0.1 })
  love.graphics.setColor(0, 0, 0)
  love.graphics.printf(currentStudent.name, nameArea.x, nameArea.y, nameArea.width)
  love.graphics.setColor(1, 1, 1)
  -- COGNOME
  --[[ local surnameArea = screenManager:calcAreaSizes({ xPerc = 0.55, yPerc =  0.44, widthPerc = 0.8, heightPerc = 0.1 })
  love.graphics.setColor(0, 0, 0)
  love.graphics.printf(currentStudent.surname, surnameArea.x, surnameArea.y, surnameArea.width)
  love.graphics.setColor(1, 1, 1) ]]
  -- DESCRIZIONE
  local descriptionArea = screenManager:calcAreaSizes({ xPerc = 0.55, yPerc = 0.6, widthPerc = 0.8, heightPerc = 0.1 })
  love.graphics.setColor(0, 0, 0)
  love.graphics.printf(currentStudent.description, descriptionArea.x, descriptionArea.y, descriptionArea.width)
  love.graphics.setColor(1, 1, 1)
  -- LISTA ATTIVITA'
--[[   for index, activity in ipairs(currentStudent.activities) do
    local yOffset = 0.67 + (index - 1) * 0.033
    local tab = screenManager:calcAreaSizes({ xPerc = 0.395, yPerc = yOffset, widthPerc = 0.8, heightPerc = 0.1 })
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(activity.name, tab.x, tab.y, tab.width)
    love.graphics.setColor(1, 1, 1)
  end ]]

end

return yearbookStudentCard
