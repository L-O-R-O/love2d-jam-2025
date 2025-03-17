local constants = require("constants")
courses = {}

function courses.load()
  mouse.registerHandler(courses, constants.SCENES_COMPUTER)
  print("loading courses!")
end

function courses.update(dt)

end

function courses.draw()
  love.graphics.draw(constants.IMAGES_SAMPLE_WINDOW, 1050, 250, 0, scaleX, scaleY)
end

function courses.keypressed(key)
  if love.keypressed("y") then

  end
end

function courses.mousePressed(x, y, button)

end

function courses.mouseHovered(x, y)

end

return courses
