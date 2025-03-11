world = {}

function world.load()
  square = {
    x = 100,
    y = 100,
    size = 20,
    speed = 100,
    path = {{100,100}, {300,100}, {300,300}, {100,300}}, -- Percorso prefissato
    currentTarget = 1
  }
end

function world.update(dt)
  updateSquare(dt)
end

function world.draw()
  love.graphics.setColor(1, 0, 0) -- Rosso
  love.graphics.rectangle("fill", square.x, square.y, square.size, square.size)
end

function world.keypressed(key)
  if (key == "escape") then
    statesManager:setState("title")
  else
    square.size = square.size + 2
  end
end

function world.gamepadpressed(joystick, button)
  square.size = square.size + 2
end

function updateSquare(dt)
  local target = square.path[square.currentTarget]
  local dx, dy = target[1] - square.x, target[2] - square.y
  local dist = math.sqrt(dx * dx + dy * dy)

  if dist > 1 then
      square.x = square.x + (dx / dist) * square.speed * dt
      square.y = square.y + (dy / dist) * square.speed * dt
  else
      square.currentTarget = square.currentTarget % #square.path + 1 -- Passa al prossimo punto
  end
end

return world
