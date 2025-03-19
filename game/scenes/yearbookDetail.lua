local constants = require("constants")

yearbookDetail = {}

local player = {
  name = "Player",
  surname = "Surname",
  activities = {
    {
      name = "Activity 1",
    },
    {
      name = "Activity 2",
    },
    {
      name = "Activity 3",
    }
  }
}

function yearbookDetail.load()
  mouse.registerHandler(yearbookDetail, constants.SCENES_YEARBOOK)
end

function yearbookDetail.update(dt)
end

function yearbookDetail.keypressed(key)
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

function yearbookDetail.mousePressed(x, y, button)
  -- Controlla se è stata cliccata una linguetta o una freccia di navigazione
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
end

function yearbookDetail.draw()
  screenManager:drawSceneBackground(constants.IMAGES_COMPUTER_BG)
end

return yearbookDetail
