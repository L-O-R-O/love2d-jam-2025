local constants = require("constants")

yearbookStudentCard = {}

local player = {
  name = "Player",
  surname = "Surname",
  description = "Description",
  activities = {
    {
      name = "Activity 1",
    },
    {
      name = "Activity 2",
    }
  }
}

function yearbookStudentCard.load()
  mouse.registerHandler(yearbookStudentCard, constants.SCENES_YEARBOOK_STUDENT_CARD)
end

function yearbookStudentCard.update(dt)
end

function yearbookStudentCard.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key =='c') then
    scenesManager:setScene(constants.SCENES_CALENDAR)
  elseif (key =='f') then
    scenesManager:setScene(constants.SCENES_COURSES)
  elseif (key =='j') then
    scenesManager:setScene(constants.SCENES_AGENDA)
  end
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  end
end

function yearbookStudentCard.mousePressed(x, y, button)
  -- Controlla se è stata cliccata una linguetta o una freccia di navigazione
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
end

function yearbookStudentCard.draw()
  screenManager:drawSceneBackground(constants.IMAGES_YB_STUDENT_CARD_BG)
end

return yearbookStudentCard
