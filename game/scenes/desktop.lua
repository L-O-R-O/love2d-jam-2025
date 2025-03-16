local constants = require("constants")
desktop = {}

function desktop.load()
  mouse.registerHandler(desktop, constants.SCENES_DESKTOP)
end

function desktop.update(dt)

end

function desktop.draw()
    --[[ local stateName = "Scrivania"
    local rectColor = {r = 0, g = 1, b = 0, a = 1}  -- Rosso
    local textColor = {r = 1, g = 1, b = 1, a = 1}  -- Bianco
    local padding = 20

    drawDebugFrame(stateName, rectColor, textColor, padding) ]]
    -- Get screen width and height
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    -- Get image dimensions
    local img = constants.IMAGES_DESKTOP_BG
    local imgWidth, imgHeight = img:getWidth(), img:getHeight()

    -- Calculate scaling factors for full screen
    local scaleX = screenWidth / imgWidth
    local scaleY = screenHeight / imgHeight

    -- Draw the image with scaling
    love.graphics.draw(img, 0, 0, 0, scaleX, scaleY)
end

function desktop.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  elseif (key =='c') then
    scenesManager:setScene(constants.SCENES_CALENDAR)
  elseif (key =='f') then
    scenesManager:setScene(constants.SCENES_COMPUTER)
  elseif (key =='j') then
    scenesManager:setScene(constants.SCENES_AGENDA)
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

function desktop.mousePressed(x, y, button)
  print('DESKTOP mousepressed')
end

function desktop.mouseHovered(x, y)
  -- print('DESKTOP mousehovered')
end

return desktop
