local constants = require("constants")
local courses = require("scenes.courses")
computer = {}

function computer.load()
  computerCurrentState = "idle"
  mouse.registerHandler(computer, constants.SCENES_COMPUTER)
  browserArea = {
    name        = "TEST_BROWSER_AREA",
    xPerc       = 0.12,
    yPerc       = 0.12,
    widthPerc   = 0.77,
    heightPerc  = 0.80,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
end

function computer.update(dt)
  --[[ if (screenManager.resizeAllAreas) then
    screenManager.areas[constants.SCENES_COMPUTER] = nil
    browserArea = screenManager:setClickableArea(constants.SCENES_COMPUTER, browserArea)
  end ]]
end

function computer.draw()
  screenManager:drawSceneBackground(constants.IMAGES_COMPUTER_BG)
  browserArea = screenManager:setDrawableArea(browserArea)
  drawDebugFrame("COMPUTER_BROWSER", browserArea)
end

function computer.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function computer.mousePressed(x, y, button)
  print('COMPUTER mousepressed')
end

function computer.mouseHovered(x, y)
  -- print('COMPUTER mousehovered')
end

function drawDebugFrame(stateName,area)
  local colorRect   = {r = 0, g = 0, b = 1, a = 1}  -- Blu
  local colorText   = {r = 0, g = 0, b = 0, a = 1}  -- Nero
  local padding     = 20
  local frameWidth  = area.width
  local frameHeight = area.height

  -- Imposta il colore del rettangolo
  love.graphics.setColor(colorRect.r, colorRect.g, colorRect.b, colorRect.a)

  -- Disegna il rettangolo attorno alla viewport con padding
  love.graphics.rectangle("line", area.x, area.y, frameWidth - 2 * padding, frameHeight - 2 * padding)

  -- Imposta il colore del testo
  love.graphics.setColor(colorText.r, colorText.g, colorText.b, colorText.a)

  -- Scrive la variabile nell'angolo in alto a sinistra
  love.graphics.setFont(constants.FONTS_NICE_CHALK)
  love.graphics.print("Debug: " .. tostring(stateName), area.x + 10, area.y + 10)

  -- Reset del colore per evitare effetti indesiderati
  love.graphics.setColor(1, 1, 1, 1)
end

return computer
