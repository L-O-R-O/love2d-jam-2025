local constants = require("constants")

calendar = {}

function calendar.load()
  mouse.registerHandler(calendar, constants.SCENES_CALENDAR)
end

function calendar.update(dt)

end

function calendar.draw()
  screenManager:drawSceneBackground(constants.IMAGES_CALENDAR_BG)
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
