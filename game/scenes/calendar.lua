local constants = require("constants")

calendar = {}

function calendar.load()
  mouse.registerHandler(calendar, constants.SCENES_CALENDAR)
end

function calendar.update(dt)

end

function calendar.draw()
  local stateName = "Calendario"
  local rectColor = {r = 0, g = 0, b = 1, a = 1}  -- Rosso
  local textColor = {r = 1, g = 1, b = 1, a = 1}  -- Bianco
  local padding = 20

  drawDebugFrame(stateName, rectColor, textColor, padding)
end

function calendar.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function drawDebugFrame(variable, colorRect, colorText, padding)
  local screenWidth = love.graphics.getWidth()
  local screenHeight = love.graphics.getHeight()

  -- Imposta il colore del rettangolo
  love.graphics.setColor(colorRect.r, colorRect.g, colorRect.b, colorRect.a)

  -- Disegna il rettangolo attorno alla viewport con padding
  love.graphics.rectangle("line", padding, padding,
                          screenWidth - 2 * padding,
                          screenHeight - 2 * padding)

  -- Imposta il colore del testo
  love.graphics.setColor(colorText.r, colorText.g, colorText.b, colorText.a)

  -- Scrive la variabile nell'angolo in alto a sinistra
  love.graphics.print("Debug: " .. tostring(variable), padding + 10, padding + 10)

  -- Reset del colore per evitare effetti indesiderati
  love.graphics.setColor(1, 1, 1, 1)
end

function calendar.mousePressed(x, y, button)
  print('CALENDAR mousepressed')
end

function calendar.mouseHovered(x, y)
  print('CALENDAR mousehovered')
end

return calendar
