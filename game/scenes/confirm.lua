local constants = require("constants")

confirm = {}
local yesButtonArea = {}
local noButtonArea = {}

local function yesButtonHandler()
  print("Yes button clicked")
end

local function noButtonHandler()
  print("No button clicked")
end

function confirm.load()
  mouse.registerHandler(confirm, constants.SCENES_CONFIRM)

  yesButtonArea = screenManager:calcAreaSizes({
    xPerc = 0.45,
    yPerc = 0.7,
    widthPerc = 0.1,
    heightPerc = 0.1
  })

  noButtonArea = screenManager:calcAreaSizes({
    xPerc = 0.65,
    yPerc = 0.7,
    widthPerc = 0.1,
    heightPerc = 0.1
  })

  screenManager:setClickableArea(constants.SCENES_CONFIRM, yesButtonArea, constants.SCENES_CONFIRM, function()
    yesButtonHandler()
  end)

  screenManager:setClickableArea(constants.SCENES_CONFIRM, noButtonArea, constants.SCENES_CONFIRM, function()
    noButtonHandler()
  end)
end

function confirm.update(dt)
end

function confirm.draw()
  -- screenManager:drawSceneBackground(constants.IMAGES_OUTCOME_WIN_SESSION)

  love.graphics.rectangle("line",yesButtonArea.x,yesButtonArea.y,yesButtonArea.width,yesButtonArea.height)
  love.graphics.rectangle("line",noButtonArea.x,noButtonArea.y,noButtonArea.width,noButtonArea.height)
end

function confirm.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function confirm.mousePressed(x, y, button)
  screenManager:checkIfIsClickable(x, y)
end

function confirm.mouseHovered(x, y)
end

return confirm
