local constants = require("constants")
desktop = {}

local isClicked = false

function desktop.load()
  mouse.registerHandler(desktop, constants.SCENES_DESKTOP)

  computerArea = {
    name        = constants.SCENES_COMPUTER,
    xPerc       = 0.27,
    yPerc       = 0.30,
    widthPerc   = 0.385,
    heightPerc  = 0.40,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  calendarArea = {
    name        = constants.SCENES_CALENDAR,
    xPerc       = 0.8,
    yPerc       = 0.06,
    widthPerc   = 0.16,
    heightPerc  = 0.37,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  agendaArea = {
    name        = constants.SCENES_AGENDA,
    xPerc       = 0.74,
    yPerc       = 0.67,
    widthPerc   = 0.26,
    heightPerc  = 0.26,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  computerArea = screenManager:setClickableArea(constants.SCENES_COMPUTER, computerArea)
  calendarArea = screenManager:setClickableArea(constants.SCENES_CALENDAR, calendarArea)
  agendaArea   = screenManager:setClickableArea(constants.SCENES_AGENDA, agendaArea)
end

function desktop.update(dt)
    if (screenManager.resizeAllAreas) then
        screenManager.areas[constants.SCENES_DESKTOP] = nil
        computerArea = screenManager:setClickableArea(constants.SCENES_COMPUTER, computerArea)
        calendarArea = screenManager:setClickableArea(constants.SCENES_CALENDAR, calendarArea)
        agendaArea   = screenManager:setClickableArea(constants.SCENES_AGENDA, agendaArea)
        screenManager.resizeAllAreas = false
    end
end

function desktop.draw()
    -- Get image dimensions
    local img = constants.IMAGES_DESKTOP_BG
    local imgWidth, imgHeight = img:getWidth(), img:getHeight()

    -- Calculate scaling factors for full screen
    local scaleX = screenManager.screenWidth / imgWidth
    local scaleY = screenManager.screenHeight / imgHeight

    -- Draw the image with scaling
    love.graphics.draw(img, 0, 0, 0, scaleX, scaleY)

    -- Draw the overlay image on top of the base image
    if isHovered then
      local overlayImg = constants.IMAGES_DESKTOP_BG_HOVERED
      love.graphics.draw(overlayImg, 0, 0, 0, scaleX, scaleY)
    end

    -- ✅ Set color for the rectangle (red)
    love.graphics.setColor(1, 0, 0, 1)
    -- love.graphics.rectangle("line", agendaArea.x, agendaArea.y, agendaArea.width, agendaArea.height)
    -- love.graphics.rectangle("line", computerArea.x, computerArea.y, computerArea.width, computerArea.height)
    -- love.graphics.rectangle("line", calendarArea.x, calendarArea.y, calendarArea.width, calendarArea.height)
    -- ✅ Reset color back to white (prevents affecting other drawings)
    love.graphics.setColor(1, 1, 1, 1)
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

function desktop.mousePressed(x, y, button)
  print('DESKTOP clicked x:'.. x .. ' and y:'..y)
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
  if (clickableAreaName) then
    mouse.loadCursor(constants.HAND_CLICKED_CURSOR)
    isClicked = true
    timer.setTimeout(function()
      isClicked = false
      mouse.loadCursor(constants.DEFAULT_CURSOR)
      scenesManager:setScene(clickableAreaName)
    end, 0.5)
  end
end

function desktop.mouseHovered(x, y)
  if (isClicked) then
    return
  end
  love.graphics.clear()
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
  if (clickableAreaName) then
    isHovered = true
    mouse.loadCursor(constants.HAND_CURSOR)
  else
    isHovered = false
    mouse.loadCursor(constants.DEFAULT_CURSOR)
  end
end

return desktop
