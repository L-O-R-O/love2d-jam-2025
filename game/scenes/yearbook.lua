local constants = require("constants")

yearbook = {}

-- Creazione dell'agenda con i nomi
local students = constants.STUDENTS


-- Creazione dei gruppi
local groups = {
  {label = "A-C", range = {"A", "C"}, background = constants.IMAGES_YB_AC},
  {label = "D-F", range = {"D", "F"}, background = constants.IMAGES_YB_DF},
  {label = "G-I", range = {"G", "I"}, background = constants.IMAGES_YB_GI},
  {label = "J-M", range = {"J", "M"}, background = constants.IMAGES_YB_JM},
  {label = "N-P", range = {"N", "P"}, background = constants.IMAGES_YB_NP},
  {label = "Q-S", range = {"Q", "S"}, background = constants.IMAGES_YB_QS},
  {label = "T-V", range = {"T", "V"}, background = constants.IMAGES_YB_TV},
  {label = "W-Z", range = {"W", "Z"}, background = constants.IMAGES_YB_WZ}
}

-- Hover dei bottoni prevArrow e nextArrow
local arrowsHoverImgs = {
  PREV_BUTTON  = constants.IMAGES_YB_ARROWS_LEFT,
  NEXT_BUTTON = constants.IMAGES_YB_ARROWS_RIGHT
}

local colorText   = {r = 0, g = 0, b = 0, a = 1}  -- Nero

-- Variabili per la gestione dell'interfaccia
local tabs           = {}
local yearbookLabels = {}
local selectedNames  = {}
local namesPerPage   = 10  -- 5 nomi per colonna a sinistra, 5 a destra
local currentPage    = 1
local maxPages       = 1
local clickables     = {}
local prevArrow      = {}
local nextArrow      = {}
local browserTabYB   = {}
local browserTabCS   = {}
local leftX, rightX  = 0.20, 0.753
local heightIndex    = 1
local background     = constants.IMAGES_YB_AC

-- Variabile per lo studente della student card
currentStudent = nil

-- Handlers degli elementi yearbook
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

local function HANDLE_LABEL_CLICK(labelArea)
  if (labelArea.student ~= nil) then
    currentStudent = labelArea.student
    scenesManager:setScene(constants.SCENES_YEARBOOK_STUDENT_CARD,false)
  end
end

local function HANDLE_BROWSER_TAB_CLICK(browserTabArea)
  if browserTabArea.name == "TAB_YB" then
    -- does nothing!!
  elseif browserTabArea.name == "TAB_CS" then
    scenesManager:setScene(constants.SCENES_COURSES,false)
  end
end

-- Funzione per filtrare i nomi in base al gruppo selezionato
function filterNames(range)
  local filtered = {}
  for _, student in ipairs(students) do
    local firstLetter = student.name:sub(1, 1)
    if firstLetter >= range[1] and firstLetter <= range[2] then
      table.insert(filtered, student)
    end
  end
  return filtered
end

-- Aggiorna il numero massimo di pagine disponibili
function updateMaxPages()
  maxPages = math.max(1, math.ceil(#selectedNames / namesPerPage))
  currentPage = 1  -- Reset alla prima pagina quando si cambia gruppo
end

function yearbook.drawPage()
  mouse.registerHandler(yearbook, constants.SCENES_YEARBOOK)
  -- Definizione frecce navigazione
  prevArrow = {
    name        = 'PREV_BUTTON',
    xPerc       = 0.12,
    yPerc       = 0.52,
    widthPerc   = 0.06,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  nextArrow = {
    name        = 'NEXT_BUTTON',
    xPerc       = 0.82,
    yPerc       = 0.52,
    widthPerc   = 0.06,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, prevArrow, prevArrow.name, PREV_PAGE)
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, nextArrow, nextArrow.name, NEXT_PAGE)

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
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, browserTabYB, browserTabYB.name, function()
    HANDLE_BROWSER_TAB_CLICK(browserTabYB)
  end, {
    browserTab = browserTabYB
  })
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, browserTabCS, browserTabCS.name, function()
    HANDLE_BROWSER_TAB_CLICK(browserTabCS)
  end, {
    browserTab = browserTabCS
  })
  heightIndex = 1
  local tabsYOffset = 0.28
  local screenHeight = screenManager.screenWidth
  local tabHeight = screenHeight / 5
  for i, group in ipairs(groups) do
    if i == 6 then
      -- Resetto l'indice per disegnare le linguette
      -- Cinque linguette a sx, tre a dx
      -- In questo modo la sesta linguetta verrá disegnata a dx
      heightIndex = 1
    end
    -- Calcolo la posizione delle linguette
    local xPerc = (i < 6) and leftX or rightX
    local yPerc = tabsYOffset + (0.091 * heightIndex)
    heightIndex = heightIndex + 1

    local widthPerc = 0.05
    local heightPerc = 0.06
    local clickableArea = {
      name        = group.label,
      xPerc       = xPerc,
      yPerc       = yPerc,
      widthPerc   = widthPerc,
      heightPerc  = heightPerc,
      x           = 0,
      y           = 0,
      width       = 0,
      height      = 0,
    }
    table.insert(tabs, clickableArea)
    screenManager:setClickableArea(constants.SCENES_YEARBOOK, clickableArea, constants.SCENES_YEARBOOK)
  end
  -- Selezione iniziale dei nomi
  selectedNames = filterNames(groups[1].range)
  updateMaxPages()

  -- Crea le aree cliccabili delle etichette
  local heightIndex = 1
  local columns = 2
  local totalItems = 10
  local rowsPerColumn = totalItems / columns

  local tabsYOffset = 0.26  -- Starting Y position (28% from top)
  local screenWidth = screenManager.screenWidth
  local centerX = screenWidth / 2  -- Center of the screen

  local boxWidthPerc = 0.18  -- 5% of the screen width
  local boxHeightPerc = 0.08 -- 6% of the screen height
  local columnSpacingPerc = 0.09 -- 2% gap between columns

  -- Calculate X positions for the two columns
  local leftX = centerX - (boxWidthPerc * screenWidth) - (columnSpacingPerc * screenWidth / 2)
  local rightX = centerX + (columnSpacingPerc * screenWidth / 2)

  for i = 1, totalItems do
      if i == rowsPerColumn + 1 then
          -- Reset height index for second column
          heightIndex = 1
      end

      -- Determine column position
      local xPerc = (i <= rowsPerColumn) and leftX or rightX
      local yPerc = tabsYOffset + (0.095 * heightIndex) -- Adjust vertical spacing
      heightIndex = heightIndex + 1

      local clickableLabel = {
          name = "Box " .. i,
          student = nil,
          xPerc = xPerc / screenWidth,
          yPerc = yPerc,
          widthPerc = boxWidthPerc,
          heightPerc = boxHeightPerc,
          x = 0,
          y = 0,
          width = 0,
          height = 0,
      }
      table.insert(yearbookLabels, clickableLabel)
      screenManager:setClickableArea(constants.SCENES_YEARBOOK, clickableLabel, constants.SCENES_YEARBOOK, function()
        HANDLE_LABEL_CLICK(clickableLabel)
      end, {
        clickableLabel = clickableLabel
      })
  end
end

function yearbook.load()
  yearbook.drawPage()
end

function yearbook.update(dt)

end

function yearbook.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key =='c') then
    scenesManager:setScene(constants.SCENES_CALENDAR)
  elseif (key =='f') then
    scenesManager:setScene(constants.SCENES_COURSES)
  elseif (key =='j') then
    scenesManager:setScene(constants.SCENES_AGENDA)
  elseif (key =='l') then
    yearbook.drawPage() --!!!DEBUG!!!
  end
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  end
end

function yearbook.drawRedBoxes()
  love.graphics.setColor(1, 0, 0) -- Red color
  for _, box in ipairs(yearbookLabels) do
      love.graphics.rectangle("line", box.x, box.y, box.width, box.height)
      local studentName = box.student ~= nil and box.student.name or "404 Student Not Found"
      love.graphics.printf(studentName, box.x, box.y, 350)
  end
  love.graphics.rectangle("line", browserTabYB.x, browserTabYB.y, browserTabYB.width, browserTabYB.height)
  love.graphics.rectangle("line", browserTabCS.x, browserTabCS.y, browserTabCS.width, browserTabCS.height)

  love.graphics.setColor(0, 0, 0) -- Reset color to black
end

function yearbook.draw()
  local alwaysShowArrows = true
  screenManager:drawSceneBackground(background)
  screenManager:drawSceneBackground(constants.IMAGES_YB_ARROWS_NONE,arrowsHoverImgs)
  love.graphics.setFont(constants.FONTS_NICE_CHALK)
  love.graphics.setColor(colorText.r, colorText.g, colorText.b, colorText.a)

  local arrowWidth    = screenManager.screenWidth * 0.06
  local arrowHeight   = screenManager.screenHeight * 0.06
  local centerX       = screenManager.screenWidth / 2

  -- DEBUG disegna le aree delle linguette
  --[[ for _, tab in ipairs(tabs) do
    love.graphics.rectangle("line", tab.x, tab.y, tab.width, tab.height)
    love.graphics.printf(tab.name, tab.x, tab.y + tab.height / 2 - 10, tab.width, "center")
  end ]]

  -- Calcola le posizioni centrate per i nomi
  local namesYOffset     = screenManager.screenHeight * 0.38
  local namesYSpacing    = screenManager.screenHeight * 0.094
  local namesXLeftStart  = screenManager.screenHeight * 0.31
  local namesXRightStart = screenManager.screenHeight * 0.16
  local startIdx = (currentPage - 1) * namesPerPage + 1
  local endIdx = math.min(startIdx + namesPerPage - 1, #selectedNames)

  local numberOfLabels = 0
  for i = startIdx, endIdx do
    local name = selectedNames[i].name
    local y = namesYOffset + (((i - startIdx) % (namesPerPage/2)) * namesYSpacing)
    local x = (i - startIdx) < namesPerPage/2 and (centerX - namesXLeftStart) or (centerX + namesXRightStart)
    love.graphics.print(name, x, y)
    if (selectedNames[i] ~= nil) then
      if (yearbookLabels[i] ~= nil) then
        yearbookLabels[i].student = selectedNames[i]
      else
        local newIndex = i % 10
        yearbookLabels[newIndex].student = selectedNames[i]
      end
    end
    numberOfLabels = numberOfLabels + 1
  end
  for j = 1, 10 do
    if (j > numberOfLabels) then
      yearbookLabels[j].student = nil
    end
  end

  --yearbook.drawRedBoxes()

  -- DEBUG: disegna le aree PREV e NEXT
  if maxPages > 1 then
    if currentPage ~= 1 or alwaysShowArrows then
      --love.graphics.setColor(1, 0, 0, 1)
      --love.graphics.rectangle("line",prevArrow.x, prevArrow.y, prevArrow.width, prevArrow.height)
      --love.graphics.printf("Prev", prevArrow.x, prevArrow.y, arrowWidth/2)
    end
    if currentPage < maxPages or alwaysShowArrows then
        --love.graphics.rectangle("line",nextArrow.x, nextArrow.y, nextArrow.width, nextArrow.height)
        --love.graphics.printf("Next", nextArrow.x, nextArrow.y, arrowWidth/2)
    end
  end
  -- Reset del colore per evitare effetti indesiderati
  love.graphics.setColor(1, 1, 1, 1)
end

function yearbook.mousePressed(x, y, button)
  -- Controlla se è stata cliccata una linguetta o una freccia di navigazione
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
  if (clickableAreaName) then
    soundsManager:playClickOnComputerScreen()
    for _, tab in ipairs(tabs) do
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
    end
  end
end

function yearbook.mouseHovered(x, y)
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

function yearbook.getCurrentStudent()
  return currentStudent
end

return yearbook
