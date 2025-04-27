local constants = require("constants")
courses = {}

-- Cache delle immagini e dimensioni
local images = {
  background = constants.IMAGES_CS_BG,
  arrows = constants.IMAGES_CS_ARROWS_NONE,
  back = constants.IMAGES_UI_BACK
}

local hoverImages = {
  arrows = {
    PREV_BUTTON = constants.IMAGES_CS_ARROWS_LEFT,
    NEXT_BUTTON = constants.IMAGES_CS_ARROWS_RIGHT
  },
  back = {
    BACK_BUTTON = constants.IMAGES_UI_BACK_HOVER
  }
}

-- Stato della scena
local state = {
  currentPage = 1,
  maxViewCourses = 13,
  allCourses = constants.ACTIVITIES,
  maxPages = math.ceil(#constants.ACTIVITIES / 13),
  reDrawAreas = false,
  isHovered = false,
  hoveredArea = nil,
  isClicked = false
}

-- Aree cliccabili
local areas = {
  browserTabYB = {
    name = 'TAB_YB',
    xPerc = 0.12,
    yPerc = 0.1,
    widthPerc = 0.20,
    heightPerc = 0.1
  },
  browserTabCS = {
    name = 'TAB_CS',
    xPerc = 0.32,
    yPerc = 0.1,
    widthPerc = 0.20,
    heightPerc = 0.1
  },
  prevArrow = {
    name = 'PREV_BUTTON',
    xPerc = 0.455,
    yPerc = 0.765,
    widthPerc = 0.05,
    heightPerc = 0.08
  },
  nextArrow = {
    name = 'NEXT_BUTTON',
    xPerc = 0.60,
    yPerc = 0.77,
    widthPerc = 0.05,
    heightPerc = 0.08
  },
  backArrow = {
    name = 'BACK_BUTTON',
    xPerc = 0.88,
    yPerc = 0.87,
    widthPerc = 0.12,
    heightPerc = 0.1
  }
}

local coursesLabels = {}

-- Handlers
local function handleBrowserTabClick(browserTabArea)
  if browserTabArea.name == "TAB_YB" then
    scenesManager:setScene(constants.SCENES_YEARBOOK, false)
  end
end

local function prevPage()
  if state.currentPage > 1 then
    state.currentPage = state.currentPage - 1
    state.reDrawAreas = true
  end
end

local function nextPage()
  if state.currentPage < state.maxPages then
    state.currentPage = state.currentPage + 1
    state.reDrawAreas = true
  end
end

local function backToDesktop()
  screenManager:setScene(constants.SCENES_DESKTOP)
end

local function handleLabelClick(labelArea)
  if labelArea.course then
    currentCourse = labelArea.course
    scenesManager:setScene(constants.SCENES_COURSES_ACTIVITY_CARD, false)
  end
end

-- LOVE FUNCTIONS
function courses.load()
  mouse.registerHandler(courses, constants.SCENES_COURSES)
  courses.drawPage()
end

function courses.update(dt)
  if state.reDrawAreas then
    courses.drawPage()
    state.reDrawAreas = false
  end
end

function courses.drawPage()
  screenManager.areas[constants.SCENES_COURSES] = {}

  -- Setup aree cliccabili
  for name, area in pairs(areas) do
    local callback = nil
    if name == "prevArrow" then callback = prevPage
    elseif name == "nextArrow" then callback = nextPage
    elseif name == "backArrow" then callback = backToDesktop
    elseif name == "browserTabYB" then callback = function() handleBrowserTabClick(area) end
    elseif name == "browserTabCS" then callback = function() handleBrowserTabClick(area) end
    end

    screenManager:setClickableArea(constants.SCENES_COURSES, area, area.name, callback)
  end

  -- Setup etichette corsi
  coursesLabels = {}
  local labelOffsetY = screenManager.screenHeight * 0.0115
  local startIdx = (state.currentPage - 1) * state.maxViewCourses + 1
  local endIdx = math.min(startIdx + state.maxViewCourses - 1, #state.allCourses)

  -- Calcola le posizioni delle etichette in base alla pagina corrente
  for i = startIdx, endIdx do
    -- Calcola la posizione relativa all'interno della pagina corrente
    local relativeIndex = i - startIdx + 1

    -- Determina la colonna (1 o 2) e la riga all'interno della colonna
    local col = relativeIndex <= 6 and 1 or 2
    local row = col == 1 and relativeIndex or relativeIndex - 6

    local coursesLabel = {
      name = 'Course Label ' .. i,
      course = state.allCourses[i],
      xPerc = col == 1 and 0.193 or 0.435,
      yPerc = col == 1 and ((row * 0.062) + 0.40) or (((row) * 0.052) + 0.3),
      widthPerc = 0.165,
      heightPerc = col == 1 and 0.05 or 0.04,
      offsetY = labelOffsetY
    }

    screenManager:setClickableArea(constants.SCENES_COURSES, coursesLabel, coursesLabel.name, function()
      handleLabelClick(coursesLabel)
    end)

    table.insert(coursesLabels, coursesLabel)
  end
end

function courses.draw()
  love.graphics.setFont(constants.FONTS_NICE_CHALK)

  -- Disegna sfondo e hover images
  screenManager:drawSceneBackground(images.background)
  screenManager:drawSceneBackground(images.arrows, hoverImages.arrows)
  screenManager:drawSceneBackground(images.back, hoverImages.back)

  -- Disegna etichette corsi
  for _, label in ipairs(coursesLabels) do
    if state.isHovered and state.hoveredArea == label.name then
      love.graphics.setColor(0.687, 0.477, 0.461, 1)
    else
      love.graphics.setColor(0.409, 0.225, 0.214, 1)
    end
    love.graphics.printf(label.course.name, label.x, label.y + label.offsetY, label.width, "center", -0.002)
  end

  love.graphics.setColor(1, 1, 1, 1)
end

function courses.keypressed(key)
  if key == constants.KEYS_ESCAPE_MENU then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif key == constants.KEYS_PAUSE_MENU then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function courses.mousePressed(x, y, button)
  local clickableArea = screenManager:getClickableArea(x, y)
  if clickableArea then
    soundsManager:playClickOnComputerScreen()
    screenManager:click(x, y)
  end
end

function courses.mouseHovered(x, y)
  if state.isClicked then return end

  love.graphics.clear()
  local clickableArea = screenManager:getClickableArea(x, y)

  if clickableArea then
    state.isHovered = true
    state.hoveredArea = clickableArea.to
    mouse.loadCursor(constants.HAND_CURSOR)
  else
    state.isHovered = false
    state.hoveredArea = nil
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
