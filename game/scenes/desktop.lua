local constants = require("constants")
desktop = {}

local isClicked = false

function desktop.load()
  mouse.registerHandler(desktop, constants.SCENES_DESKTOP)
  desktopHoveredImages = {
    yearBook = constants.IMAGES_HOVER_DESKTOP_COMPUTER,
    courses  = constants.IMAGES_HOVER_DESKTOP_COMPUTER,
    calendar = constants.IMAGES_HOVER_DESKTOP_CALENDAR,
    agenda   = constants.IMAGES_HOVER_DESKTOP_AGENDA
  }
  computerArea = {
    name        = constants.SCENES_COURSES,
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
  soundArea = {
    name        = "SOUND_BUTTON",
    xPerc       = 0.016,
    yPerc       = 0.935,
    widthPerc   = 0.03,
    heightPerc  = 0.05,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  helpButtonArea = {
    name        = "HELP_BUTTON",
    xPerc       = 0.046,
    yPerc       = 0.935,
    widthPerc   = 0.03,
    heightPerc  = 0.05,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  helpButtonArea = screenManager:setClickableArea(constants.SCENES_DESKTOP, helpButtonArea, helpButtonArea.name, function()
    desktop.transitionTo(constants.SCENES_TUTORIAL)
  end)
  soundArea = screenManager:setClickableArea(constants.SCENES_DESKTOP, soundArea, soundArea.name, function()
    desktop.toggleMusic()
  end)
  computerArea = screenManager:setClickableArea(constants.SCENES_DESKTOP, computerArea, constants.SCENES_YEARBOOK, function()
    desktop.transitionTo(constants.SCENES_YEARBOOK)
  end)
  calendarArea = screenManager:setClickableArea(constants.SCENES_DESKTOP, calendarArea, constants.SCENES_CALENDAR, function()
    desktop.transitionTo(constants.SCENES_CALENDAR)
  end)
  agendaArea   = screenManager:setClickableArea(constants.SCENES_DESKTOP, agendaArea, constants.SCENES_AGENDA, function()
    desktop.transitionTo(constants.SCENES_AGENDA)
  end)
end

function desktop.transitionTo(scene)
  soundsManager:playSceneTransitionSound(constants.SCENES_DESKTOP,scene)
  mouse.loadCursor(constants.HAND_CLICKED_CURSOR)
  isClicked = true
  timer.setTimeout(function()
    isClicked = false
    mouse.loadCursor(constants.DEFAULT_CURSOR)
    scenesManager:setScene(scene)
  end, 0.5)
end

function desktop.toggleMusic()
  if (musicManager.isPlayingBgMusic) then
    musicManager:stopMusic()
  else
    musicManager:startMusic()
  end
end


function desktop.update(dt)
    if (screenManager.resizeAllAreas) then
      screenManager.areas[constants.SCENES_DESKTOP] = nil
      computerArea = screenManager:setClickableArea(constants.SCENES_DESKTOP, computerArea, constants.SCENES_YEARBOOK)
      calendarArea = screenManager:setClickableArea(constants.SCENES_DESKTOP, calendarArea, constants.SCENES_CALENDAR)
      agendaArea   = screenManager:setClickableArea(constants.SCENES_DESKTOP, agendaArea, constants.SCENES_AGENDA)
    end
end

function desktop.draw()
  screenManager:drawSceneBackground(constants.IMAGES_DESKTOP_BG,desktopHoveredImages)
  screenManager:drawSceneBackground(constants.IMAGES_HOVER_DESKTOP_POSTITS)
  love.graphics.draw(constants.IMAGES_HELP,helpButtonArea.x,helpButtonArea.y,0,0.25,0.25)
  if (musicManager.isPlayingBgMusic) then
    love.graphics.draw(constants.IMAGES_SOUND_ON,soundArea.x,soundArea.y,0,0.25,0.25)
  else
    love.graphics.draw(constants.IMAGES_SOUND_OFF,soundArea.x,soundArea.y,0,0.25,0.25)
  end
end

function desktop.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function desktop.mousePressed(x, y, button)
  local clickableArea = screenManager:getClickableArea(x, y)
  -- trasferisciti
  if (clickableArea) then
    screenManager:click(x, y)
  end
end

function desktop.mouseHovered(x, y)
  if (isClicked) then
    return
  end
  love.graphics.clear()
  local clickableArea = screenManager:getClickableArea(x, y)
  if (clickableArea) then
    isHovered = true
    hoveredArea = clickableArea.to
    mouse.loadCursor(constants.HAND_CURSOR)
  else
    isHovered = false
    hoveredArea = nil
    mouse.loadCursor(constants.DEFAULT_CURSOR)
  end
end

return desktop
