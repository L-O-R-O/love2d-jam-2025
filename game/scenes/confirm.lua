local constants = require("constants")

confirm = {}
local yesButtonArea = {}
local noButtonArea = {}
local bg = constants.IMAGES_CONFIRM_BG
local selectedDay = 0
local selectedMonth = 0
local selectedMonthLabel = ''
local selectedDayLabel = ''


local function yesButtonHandler()
  GameManager:tryDate(selectedDay)
  local outcome = GameManager:getOutcomeState()
  if outcome == constants.OUTCOMESTATE[1] then
    SoundsManager:playMe(constants.SOUNDS_RIGHT_CHOISE)
  elseif outcome == constants.OUTCOMESTATE[2] then
    SoundsManager:playMe(constants.SOUNDS_WRONG_CHOISE)
  elseif outcome == constants.OUTCOMESTATE[3] then
    SoundsManager:playMe(constants.SOUNDS_SELECTION)
  else
    SoundsManager:playMe(constants.SOUNDS_FAILED)
  end
  screenManager:setScene(constants.SCENES_OUTCOME, false)
end

local function noButtonHandler()
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
  local day = calendar.getSelectedDate()
  selectedDay = day.day
  selectedMonthLabel = day.month
  selectedDayLabel = day.dayLabel
end

function confirm.draw()
  if (bg == nil) then
    return
  end
  screenManager:drawSceneBackground(bg)

  love.graphics.push()
  love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
  love.graphics.rotate(math.rad(5))
  love.graphics.translate(-love.graphics.getWidth() / 2, -love.graphics.getHeight() / 2)

  love.graphics.setColor(1, 1, 1, 1) -- Reset color to white
  love.graphics.setColor(0, 0, 0, 1) -- Set color to black
  love.graphics.setFont(constants.FONTS_NICE_CHALK_CONFIRM)


  -- Draw selected day label
  love.graphics.printf(
    selectedDayLabel,
    0,
    love.graphics.getHeight() * 0.425,
    love.graphics.getWidth() - 80,
    "center"
  )

  -- Draw selected day
  love.graphics.printf(
    selectedDay,
    0,
    love.graphics.getHeight() * 0.425,
    love.graphics.getWidth()+ 20,
    "center"
  )

  -- Draw selected month
  love.graphics.printf(
    selectedMonthLabel,
    0,
    love.graphics.getHeight() * 0.425,
    love.graphics.getWidth() + 160,
    "center"
  )
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.pop()

end

function confirm.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function confirm.mousePressed(x, y, button)
  screenManager:click(x, y)
end

function confirm.mouseHovered(x, y)
  local clickableArea = screenManager:getClickableArea(x, y)
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
