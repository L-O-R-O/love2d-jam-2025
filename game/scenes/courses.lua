local constants = require("constants")
courses = {}

local browserTabYB = {}
local browserTabCS = {}
local prevArrow    = {}
local nextArrow    = {}

-- Hover dei bottoni prevArrow e nextArrow
local arrowsHoverImgs = {
  PREV_BUTTON  = constants.IMAGES_CS_ARROWS_LEFT,
  NEXT_BUTTON = constants.IMAGES_CS_ARROWS_RIGHT
}

-- Handlers degli elementi activities/courses
local function HANDLE_BROWSER_TAB_CLICK(browserTabArea)
  if browserTabArea.name == "TAB_YB" then
    scenesManager:setScene(constants.SCENES_YEARBOOK,false)
  elseif browserTabArea.name == "TAB_CS" then
    -- does nothing se non il click sound!!
  end
end

local function PREV_PAGE()
  if currentPage > 1 then
    currentPage = currentPage - 1
  end
end

local function NEXT_PAGE()
  if currentPage < maxPages then
    currentPage = currentPage + 1
  end
end

-- LOVE FUNCTIONS
function courses.load()
  mouse.registerHandler(courses, constants.SCENES_COURSES)
  courses.drawPage()
end

function courses.update(dt)

end

function courses.drawPage()
  -- Definizione tab orizzontali del browser
  browserTabYB = {
    name        = 'TAB_YB',
    xPerc       = 0.12,
    yPerc       = 0.1,
    widthPerc   = 0.20,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  browserTabCS = {
    name        = 'TAB_CS',
    xPerc       = 0.32,
    yPerc       = 0.1,
    widthPerc   = 0.20,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  prevArrow = {
    name        = 'PREV_BUTTON',
    xPerc       = 0.455,
    yPerc       = 0.765,
    widthPerc   = 0.05,
    heightPerc  = 0.08,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  nextArrow = {
    name        = 'NEXT_BUTTON',
    xPerc       = 0.60,
    yPerc       = 0.77,
    widthPerc   = 0.05,
    heightPerc  = 0.08,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  screenManager:setClickableArea(constants.SCENES_COURSES, prevArrow, prevArrow.name, PREV_PAGE)
  screenManager:setClickableArea(constants.SCENES_COURSES, nextArrow, nextArrow.name, NEXT_PAGE)
  screenManager:setClickableArea(constants.SCENES_COURSES, browserTabYB, browserTabYB.name, function()
    HANDLE_BROWSER_TAB_CLICK(browserTabYB)
  end, {
    browserTab = browserTabYB
  })
  screenManager:setClickableArea(constants.SCENES_COURSES, browserTabCS, browserTabCS.name, function()
    HANDLE_BROWSER_TAB_CLICK(browserTabCS)
  end, {
    browserTab = browserTabCS
  })
end

function courses.draw()
  screenManager:drawSceneBackground(constants.IMAGES_CS_BG)
  screenManager:drawSceneBackground(constants.IMAGES_CS_ARROWS_NONE,arrowsHoverImgs)
  --[[  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.rectangle("line", prevArrow.x, prevArrow.y, prevArrow.width, prevArrow.height)
  love.graphics.rectangle("line", nextArrow.x, nextArrow.y, nextArrow.width, nextArrow.height)
  love.graphics.setColor(1, 1, 1, 1) ]]
end

function courses.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  elseif (key == "y") then

  end
end

function courses.mousePressed(x, y, button)
  -- Controlla se è stata cliccata una linguetta o una freccia di navigazione
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
  if (clickableAreaName) then
    soundsManager:playClickOnComputerScreen()
    --[[ for _, tab in ipairs(tabs) do
      if x >= tab.x and x <= tab.x + tab.width and y >= tab.y and y <= tab.y + tab.height then
        local range = ''
        for _, group in ipairs(groups) do
          if group.label == tab.name then
            range = group.range
            background = group.background
            break
          end
        end
        selectedNames = filterNames(range)
        updateMaxPages()
        return
      end
    end ]]
  end
end

function courses.mouseHovered(x, y)
  if (isClicked) then
    return
  end
  love.graphics.clear()
  local clickableAreaName = screenManager:checkIfIsClickable(x, y, "hover")
  if (clickableAreaName) then
    isHovered = true
    hoveredArea = clickableAreaName.to
    mouse.loadCursor(constants.HAND_CURSOR)
  else
    isHovered = false
    hoveredArea = nil
    mouse.loadCursor(constants.DEFAULT_CURSOR)
  end
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

return courses
