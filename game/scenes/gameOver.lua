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

  local textTitle = "Game Over"
  local textContent =
    "The magical land has fallen. Maybe it burned to ashes. Maybe the emperor was devoured by rampaging goblins. Or — worse — maybe nothing happened at all, because the party never found a day to actually play. It now exists in limbo, its fate forever unwritten, because Kyle had trombone practice and Emily forgot about her cousin's wedding. In the end the true villain wasn't a dark sorcerer or an ancient dragon… it was scheduling conflicts."
  local textDescription = "Press ESC to return to the main menu"
  local font = love.graphics.getFont()
  local textTitleWidth = font:getWidth(textTitle)
  local textTitleHeight = font:getHeight()
  local x = (love.graphics.getWidth() - textTitleWidth) / 2
  local y = (love.graphics.getHeight() - textTitleHeight) / 2 - 100

  love.graphics.print(textTitle, x, y)
  love.graphics.printf(textContent, 0, y + textTitleHeight, love.graphics.getWidth(), "center")
  love.graphics.printf(
    textDescription,
    0,
    love.graphics.getHeight() - textTitleHeight,
    love.graphics.getWidth(),
    "center"
  )

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
