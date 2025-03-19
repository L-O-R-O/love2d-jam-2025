local constants = require("constants")
calendar = {}
local currentMonth = 1
local currentMonthLabel = "MARCH"
local monthFont = love.graphics.newFont("assets/font/NiceChalk.ttf", 70)
local dayFont = love.graphics.newFont("assets/font/NiceChalk.ttf", 45)

function calendar.load()
  mouse.registerHandler(calendar, constants.SCENES_CALENDAR)
end

function calendar.update(dt)
end

local previousGroup = nil
local redCircle = {
  draw = false,
  day = ''
}

local function dateClicked(day)
  print("Day clicked: " .. day)
end

function calendar.draw()

  screenManager:drawSceneBackground(constants.IMAGES_CALENDAR_BG)
  love.graphics.setFont(monthFont)
  local monthArea = screenManager:calcAreaSizes({
    xPerc = 0.63,
    yPerc = 0.22,
    widthPerc = 0.2,
    heightPerc = 0.1
  })
  love.graphics.setColor(0, 0, 0)
  love.graphics.printf(currentMonthLabel, monthArea.x, monthArea.y, monthArea.width, "center")
  love.graphics.setColor(1, 1, 1)

  love.graphics.setFont(dayFont)
  local daysInMonth = constants.DAYS_IN_MONTH[currentMonth]
  local colIndex = 1
  local xOffset, yOffset = 0.55, 0.25
  local yDiagonalOffset = 0
  local previousGroup = 1
  for day = 1, daysInMonth do
    local group = math.ceil(day / 5)
    if group ~= previousGroup then
      yDiagonalOffset = 0
    end

    local xPerc = xOffset + (colIndex * 0.055)
    local yPerc = yOffset + (group * 0.08) + yDiagonalOffset
    yDiagonalOffset = yDiagonalOffset - 0.006

    local nameArea = screenManager:calcAreaSizes({
      xPerc = xPerc,
      yPerc = yPerc,
      widthPerc = 0.04,
      heightPerc = 0.06
    })

    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(day, nameArea.x, nameArea.y, nameArea.width, "center")
    love.graphics.setColor(1, 1, 1)

    if (redCircle.draw == true and redCircle.day == day) then
      local image = constants.IMAGES_CALENDAR_RED_CIRCLE
      local sx = nameArea.width / image:getWidth() + 0.1
      local sy = nameArea.height / image:getHeight() + 0.1
      local x = nameArea.x + (nameArea.width - image:getWidth() * sx) / 2
      local y = nameArea.y + (nameArea.height - image:getHeight() * sy) / 2
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.draw(image, x, y, 0, sx, sy)
    end

    screenManager:setClickableArea(constants.SCENES_CALENDAR, nameArea, constants.SCENES_CALENDAR, function()
      dateClicked(day)
    end, {
      day = day
    })
    colIndex = (colIndex % 5) + 1
    previousGroup = group
  end
end

function calendar.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function calendar.mousePressed(x, y, button)
  local clickableArea = screenManager:checkIfIsClickable(x, y)
end

function calendar.mouseHovered(x, y)
  local clickableArea = screenManager:checkIfIsClickable(x, y, "hover")
  if (clickableArea) then
    mouse.loadCursor(constants.HAND_CURSOR)
    redCircle = {
      draw = true,
      day = clickableArea.data.day
    }
  else
    redCircle = {
      draw = false,
      day = nil
    }
    mouse.loadCursor(constants.DEFAULT_CURSOR)
  end
end

return calendar
