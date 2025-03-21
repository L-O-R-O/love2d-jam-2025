local constants = require("constants")

gameOver = {}

function gameOver.load()
  -- No need for mouse handler since we only handle keyboard
end

function gameOver.update(dt)
  -- No update logic needed
end

function gameOver.draw()
  -- Set background to black
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

  -- Draw "Game Over" text in white
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.setFont(constants.FONTS_MAIN_MENU)

  local text = "Game Over"
  local font = love.graphics.getFont()
  local textWidth = font:getWidth(text)
  local textHeight = font:getHeight()
  local x = (love.graphics.getWidth() - textWidth) / 2
  local y = (love.graphics.getHeight() - textHeight) / 2

  love.graphics.print(text, x, y)

  -- Reset color
  love.graphics.setColor(1, 1, 1, 1)
end

function gameOver.keypressed(key)
  if key == constants.KEYS_ESCAPE_MENU then
    GameManager:resetStrikes()
    scenesManager:setScene(constants.SCENES_TITLE, false) -- Add false to prevent transition
  end
end

-- Add these empty functions to match other scenes
function gameOver.mousePressed(x, y, button) end

return gameOver
