local constants = require("constants")

calendar = {}

local currentMonth = 1

-- local xPerc = 0
-- local yPerc = 0


function calendar.load()
  mouse.registerHandler(calendar, constants.SCENES_CALENDAR)
end

function calendar.update(dt)
end

local previousGroup = nil

function calendar.draw()
  constants.setFont("NiceChalk", 60)
  screenManager:drawSceneBackground(constants.IMAGES_CALENDAR_BG)

  local daysInMonth = constants.DAYS_IN_MONTH[currentMonth]
  local colIndex = 1
  local xOffset, yOffset = 0.55, 0.22
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
    love.graphics.rectangle("line", nameArea.x, nameArea.y, nameArea.width, nameArea.height)

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
  print('CALENDAR mousepressed')

end

function calendar.mouseHovered(x, y)
  -- print('CALENDAR mousehovered')
end

return calendar
