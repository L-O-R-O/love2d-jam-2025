local constants = require("constants")

confirm = {}
local yesButtonArea = {}
local noButtonArea = {}
local bg = constants.IMAGES_CONFIRM_BG


local function yesButtonHandler()
  -- Chiedo al GameManager di verificare che il giorno selezionato sia valido
  -- Subito dopo faccio la navigazione verso outcome
  print("yesButtonHandler")
  print(calendar.getSelectedDay())
  -- GameManager:tryDate(day)
  screenManager:setScene(constants.SCENES_OUTCOME, false)
end

local function noButtonHandler()
  print("noButtonHandler")
  print(calendar.getSelectedDay())
  scenesManager:setScene(constants.SCENES_CALENDAR, false)
end

function confirm.load()
  mouse.registerHandler(confirm, constants.SCENES_CONFIRM)

  yesButtonArea = screenManager:calcAreaSizes({
    xPerc = 0.42,
    yPerc = 0.58,
    widthPerc = 0.05,
    heightPerc = 0.05
  })

  noButtonArea = screenManager:calcAreaSizes({
    xPerc = 0.51,
    yPerc = 0.59,
    widthPerc = 0.05,
    heightPerc = 0.05
  })

  screenManager:setClickableArea(constants.SCENES_CONFIRM, yesButtonArea, constants.SCENES_CONFIRM, function()
    yesButtonHandler()
  end, { toConfirm = true })

  screenManager:setClickableArea(constants.SCENES_CONFIRM, noButtonArea, constants.SCENES_CONFIRM, function()
    noButtonHandler()
  end, { toConfirm = false })
end

function confirm.update(dt)
end

function confirm.draw()
  if (bg == nil) then
    return
  end

  screenManager:drawSceneBackground(bg)
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
  local clickableArea = screenManager:checkIfIsClickable(x, y, "hover")
  bg = constants.IMAGES_CONFIRM_BG
  if (clickableArea) then
    local toConfirm = clickableArea.data.toConfirm
    if toConfirm then
      bg = constants.IMAGES_CONFIRM_HOVER_YES_BG
    else
      bg = constants.IMAGES_CONFIRM_HOVER_NO_BG
    end
  end
end

return confirm
