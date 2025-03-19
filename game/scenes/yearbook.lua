local constants = require("constants")

yearbook = {}

-- Creazione dell'agenda con i nomi
local allNames = {
  "Alberto", "Anna", "Bianca", "Carlo", "Davide", "Elisa", "Francesco", "Giorgio",
  "Luca", "Marco", "Nadia", "Olga", "Paolo", "Riccardo", "Sara", "Tommaso", "Ugo",
  "Vittoria", "Zeno", "Andrea", "Barbara", "Claudio", "Daniela", "Emanuele", "Federica",
  "Giacomo", "Irene", "Jessica", "Leonardo", "Massimo", "Nicole", "Orlando", "Pietro",
  "Quirino", "Raffaella", "Silvio", "Teresa", "Ubaldo", "Vanessa", "Walter", "Xenia",
  "Yari", "Zaira", "Antonio", "Beatrice", "Cesare", "Domenico", "Emma", "Filippo", "Ginevra", "Henry",
  "Isabella", "Jacopo", "Kristian", "Laura", "Matteo", "Noemi", "Oscar", "Pietra", "Quentin", "Rosa",
  "Simone", "Teodoro", "Ursula", "Valerio", "Wendy", "Xander", "Yvonne", "Zaccaria", "Alessio", "Biagio",
  "Corrado", "Diego", "Elena", "Fabio", "Giulia", "Harald", "Ilaria", "Jasmine", "Kevin", "Ludovico",
  "Marta", "Nicolas", "Oriana", "Pierluigi", "Quirina", "Roberto", "Selene", "Tobia", "Umberto", "Viola"
}

-- Creazione dei gruppi
local groups = {
  {label = "A-C", range = {"A", "C"}},
  {label = "D-F", range = {"D", "F"}},
  {label = "G-I", range = {"G", "I"}},
  {label = "J-M", range = {"J", "M"}},
  {label = "N-P", range = {"N", "P"}},
  {label = "Q-S", range = {"Q", "S"}},
  {label = "T-Z", range = {"T", "Z"}}
}

local colorText   = {r = 0, g = 0, b = 0, a = 1}  -- Nero

-- Variabili per la gestione dell'interfaccia
local tabs          = {}
local selectedNames = {}
local namesPerPage  = 10  -- 5 nomi per colonna a sinistra, 5 a destra
local currentPage   = 1
local maxPages      = 1
local arrowWidth    = screenManager.screenWidth * 0.06
local arrowHeight   = screenManager.screenHeight * 0.06
local clickables    = {}
local prevArrow     = {}
local nextArrow     = {}
local leftX, rightX = 0.15, 0.75
local heightIndex   = 1


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

function yearbook.load()
  mouse.registerHandler(yearbook, constants.SCENES_YEARBOOK)
  -- Definizione frecce navigazione
  prevArrow = {
    name        = 'PREV_BUTTON',
    xPerc       = 0.1,
    yPerc       = 0.9,
    widthPerc   = 0.1,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  nextArrow = {
    name        = 'NEXT_BUTTON',
    xPerc       = 0.9,
    yPerc       = 0.9,
    widthPerc   = 0.1,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, prevArrow, constants.SCENES_YEARBOOK, PREV_PAGE)
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, nextArrow, constants.SCENES_YEARBOOK, NEXT_PAGE)

  local screenHeight = love.graphics.getHeight()
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
    local yPerc = (0.15 * heightIndex)
    heightIndex = heightIndex + 1

    local widthPerc = 0.1
    local heightPerc = 0.1
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

  -- Selezione iniziale
  selectedNames = filterNames(groups[1].range)
  updateMaxPages()
end

function yearbook.update(dt)
end

-- Funzione per filtrare i nomi in base al gruppo selezionato
function filterNames(range)
  local filtered = {}
  for _, name in ipairs(allNames) do
    local firstLetter = name:sub(1, 1)
    if firstLetter >= range[1] and firstLetter <= range[2] then
      table.insert(filtered, name)
    end
  end
  return filtered
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
  end
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  end
end

-- Aggiorna il numero massimo di pagine disponibili
function updateMaxPages()
  maxPages = math.max(1, math.ceil(#selectedNames / namesPerPage))
  currentPage = 1  -- Reset alla prima pagina quando si cambia gruppo
end

function yearbook.mousePressed(x, y, button)
  -- Controlla se è stata cliccata una linguetta o una freccia di navigazione
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
  if (clickableAreaName) then
    for _, tab in ipairs(tabs) do
      if x >= tab.x and x <= tab.x + tab.width and y >= tab.y and y <= tab.y + tab.height then
        local range = ''
        for _, group in ipairs(groups) do
          if group.label == tab.name then
            range = group.range
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

function yearbook.draw()
  screenManager:drawSceneBackground(constants.IMAGES_)
  love.graphics.setColor(colorText.r, colorText.g, colorText.b, colorText.a)
  love.graphics.setFont(constants.FONTS_NICE_CHALK)

  local centerX = love.graphics.getWidth() / 2
  local screenHeight = love.graphics.getHeight()

  -- Disegna le linguette
  for _, tab in ipairs(tabs) do
    love.graphics.rectangle("line", tab.x, tab.y, tab.width, tab.height)
    love.graphics.printf(tab.name, tab.x, tab.y + tab.height / 2 - 10, tab.width, "center")
  end

    -- Calcola le posizioni centrate per i nomi
    local yOffset = 100
    local startIdx = (currentPage - 1) * namesPerPage + 1
    local endIdx = math.min(startIdx + namesPerPage - 1, #selectedNames)

    for i = startIdx, endIdx do
      local name = selectedNames[i]
      local y = yOffset + (((i - startIdx) % 4) * 50)
      local x = (i - startIdx) < 4 and (centerX - 150) or (centerX + 50)
      love.graphics.print(name, x, y)
    end

  -- Disegna le frecce di navigazione
  if maxPages > 1 then
    if currentPage ~= 1 then
      love.graphics.printf("Prev", prevArrow.x, prevArrow.y, arrowWidth/2)
    end
    if currentPage < maxPages then
        love.graphics.printf("Next", nextArrow.x, nextArrow.y, arrowWidth/2)
    end
  end
  -- Reset del colore per evitare effetti indesiderati
  love.graphics.setColor(1, 1, 1, 1)
end

return yearbook
