local constants = require("constants")
calendar = {}
local calendarArea = {}
local currentMonthLabel = "MARCH"
local monthFont = love.graphics.newFont("assets/font/NiceChalk.ttf", 70)
local dayFont = love.graphics.newFont("assets/font/NiceChalk.ttf", 45)
local dayNameFont = love.graphics.newFont("assets/font/NiceChalk.ttf", 15)
local selectedDay = nil
local selectedDayLabel = nil

-- Calcolo mese corrente
local currentMonth = GameManager:getMonth()
local currentMonthLabel = constants.MONTH_NAMES[currentMonth]
local firstDayOfTheMonth = CalendarManager:getFirstDayOfMonth(currentMonth)

local previousGroup = nil
local redCircle = {
  toDraw = false,
  day = ''
}

-- Lista dei giorni della settimana, abbreviati ed in uppercase
local daysOfWeek = {}
for _, day in ipairs(constants.WEEK_DAYS) do
  table.insert(daysOfWeek, day:sub(1, 3):upper())
end

function calendar.getSelectedDate()
  return { day = selectedDay, month = currentMonthLabel, dayLabel = selectedDayLabel }
end

function calendar.load()
  mouse.registerHandler(calendar, constants.SCENES_CALENDAR)
  calendarArea = screenManager:calcAreaSizes({
    xPerc = 0.27,
    yPerc = 0.05,
    widthPerc = 0.42,
    heightPerc = 0.90
  })
end

function calendar.update(dt)
  currentMonth = GameManager:getMonth()
  currentMonthLabel = constants.MONTH_NAMES[currentMonth]
  firstDayOfTheMonth = CalendarManager:getFirstDayOfMonth(currentMonth)
end

local function dateClicked(day)
  local dayOfWeekIndex = ((firstDayOfTheMonth + day - 2) % #daysOfWeek) + 1
  selectedDay = day
  selectedDayLabel = string.sub(constants.WEEK_DAYS[dayOfWeekIndex], 1,3)
  scenesManager:setScene(constants.SCENES_CONFIRM, false)
end

function calendar.draw()
  screenManager:drawSceneBackground(constants.IMAGES_CALENDAR_BG)
  love.graphics.setColor(0, 0, 1)
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(monthFont)
  local monthArea = screenManager:calcAreaSizes({
    xPerc = 0.4,
    yPerc = 0.17,
    widthPerc = 0.2,
    heightPerc = 0.1
  })
  love.graphics.setColor(0.9, 0.9, 0.9)
  love.graphics.printf(currentMonthLabel, monthArea.x, monthArea.y, monthArea.width, "center")
  love.graphics.setColor(1, 1, 1)

  local dayOfWeek
  local daysInMonth = constants.DAYS_IN_MONTH_ORIGINAL[currentMonth]
  local daysInMonthOriginal = constants.DAYS_IN_MONTH_ORIGINAL[currentMonth]
  local colIndex = 1
  local xOffset, yOffset = 0.309, 0.22
  local yDiagonalOffset = 0
  local previousGroup = 1
  for day = 1, daysInMonthOriginal do
    local group = math.ceil(day / 5)
    if group ~= previousGroup then
      yDiagonalOffset = 0
    end

    local xPerc = xOffset + (colIndex * 0.055)
    local yPerc = yOffset + (group * 0.08) + yDiagonalOffset
    yDiagonalOffset = yDiagonalOffset - 0.002

    local nameArea = screenManager:calcAreaSizes({
      xPerc = xPerc,
      yPerc = yPerc,
      widthPerc = 0.04,
      heightPerc = 0.06
    })

    love.graphics.setFont(dayNameFont)
    -- Seleziono il giorno della settimana
    local dayOfWeekIndex = ((firstDayOfTheMonth + day - 2) % #daysOfWeek) + 1
    dayOfWeek = daysOfWeek[dayOfWeekIndex]

    if day <= daysInMonth then
      -- Stampo nome giorno
      love.graphics.setColor(0, 0, 0)
      love.graphics.printf(dayOfWeek, nameArea.x - 0.01, nameArea.y -20, nameArea.width, "center")
      love.graphics.setColor(1, 1, 1)

      -- Stampo numero giorno
      love.graphics.setFont(dayFont)
      love.graphics.setColor(0, 0, 0)
      love.graphics.printf(day, nameArea.x, nameArea.y, nameArea.width, "center")
      love.graphics.setColor(1, 1, 1)
    else
      -- Stampo nome giorno
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.printf(dayOfWeek, nameArea.x - 0.01, nameArea.y -20, nameArea.width, "center")
      love.graphics.setColor(1, 1, 1)

      -- Stampo numero giorno
      love.graphics.setFont(dayFont)
      love.graphics.setColor(0.5, 0.5, 0.5)
      love.graphics.printf(day, nameArea.x, nameArea.y, nameArea.width, "center")
      love.graphics.setColor(1, 1, 1)
    end

    if day <= daysInMonth then
      -- Controllo se disegnare il cerchio rosso
      if (redCircle.toDraw == true and redCircle.day == day) then
        local image = constants.IMAGES_CALENDAR_RED_CIRCLE
        local sx = nameArea.width / image:getWidth() + 0.1
        local sy = nameArea.height / image:getHeight() + 0.1
        local x = nameArea.x + (nameArea.width - image:getWidth() * sx) / 2
        local y = nameArea.y + (nameArea.height - image:getHeight() * sy) / 2 - 10
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(image, x, y, 0, sx, sy)
      end

      local doesAreaExists = screenManager:checkIfAreaExists(constants.SCENES_CALENDAR, day)
      if (doesAreaExists == false) then
        print("Creating clickable area for day " .. day)
        screenManager:setClickableArea(constants.SCENES_CALENDAR, nameArea, constants.SCENES_CALENDAR,
                            function()
                              dateClicked(day)
                            end, {
                              nameAreaId = day,
                              day = day
                            })
      end
    end

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
  if screenManager:checkIfClickingOutside(x,y,calendarArea) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  end
  screenManager:click(x, y)
end

function calendar.mouseHovered(x, y)
  local clickableArea = screenManager:getClickableArea(x, y)
  -- Se GIORNO é in hover, disegno il cerchio rosso
  -- e cambio il cursore
  if (clickableArea) then
    mouse.loadCursor(constants.HAND_CURSOR)
    redCircle.day = clickableArea.data.day
    redCircle.toDraw = true
  -- Altrimenti resetto il cursore a quello di default
  else
    redCircle.day = nil
    redCircle.toDraw = false
    mouse.loadCursor(constants.DEFAULT_CURSOR)
  end
end

return calendar
