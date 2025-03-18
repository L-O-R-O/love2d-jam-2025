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

-- Variabili per la gestione dell'interfaccia
local tabs = {}
local selectedNames = {}
local namesPerPage = 8  -- 4 nomi per colonna a sinistra, 4 a destra
local currentPage = 1
local maxPages = 1

local arrowWidth = 120
local arrowHeight = 60

function yearbook.load()
  mouse.registerHandler(yearbook, constants.SCENES_YEARBOOK)

  -- Posizione delle linguette (sinistra e destra)
  local leftX, rightX = 10, love.graphics.getWidth() - 60
  local screenHeight = love.graphics.getHeight()
  local tabHeight = screenHeight / 5

  for i, group in ipairs(groups) do
    local x = (i <= #groups / 2 or group.label == "J-M") and leftX or rightX
    local y = tabHeight * ((i - 1) % (#groups / 2))
    table.insert(tabs, {
      x = x,
      y = y,
      width = 50,
      height = tabHeight,
      label = group.label,
      range = group.range
    })
  end

  -- Selezione iniziale
  selectedNames = filterNames(groups[1].range)
  updateMaxPages()
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

-- Aggiorna il numero massimo di pagine disponibili
function updateMaxPages()
  maxPages = math.max(1, math.ceil(#selectedNames / namesPerPage))
  currentPage = 1  -- Reset alla prima pagina quando si cambia gruppo
end

function yearbook.mousePressed(x, y, button)

    -- Controlla se è stata cliccata una linguetta
    for _, tab in ipairs(tabs) do
      if x >= tab.x and x <= tab.x + tab.width and y >= tab.y and y <= tab.y + tab.height then
        selectedNames = filterNames(tab.range)
        updateMaxPages()
        return
      end
    end

    -- Controlla se è stata cliccata una freccia di navigazione
    local centerX = love.graphics.getWidth() / 2
    local screenHeight = love.graphics.getHeight()
    local arrowY = screenHeight - 100

    -- Freccia sinistra
    if x >= centerX - 120 and x <= centerX - 120 + arrowWidth and y >= arrowY and y <= arrowY + arrowHeight then
      if currentPage > 1 then
        currentPage = currentPage - 1
      end
      return
    end

    -- Freccia destra
    if x >= centerX + 40 and x <= centerX + 40 + arrowWidth and y >= arrowY and y <= arrowY + arrowHeight then
      if currentPage < maxPages then
        currentPage = currentPage + 1
      end
      return
    end

end

function yearbook.draw()
  local centerX = love.graphics.getWidth() / 2
  local screenHeight = love.graphics.getHeight()

  -- Disegna le linguette
  for _, tab in ipairs(tabs) do
    love.graphics.rectangle("line", tab.x, tab.y, tab.width, tab.height)
    love.graphics.printf(tab.label, tab.x, tab.y + tab.height / 2 - 10, tab.width, "center")
  end

  -- Disegna la "pagina centrale" dell'agenda
  love.graphics.line(centerX, 0, centerX, screenHeight)

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
    local arrowY = screenHeight - 100
    -- love.graphics.rectangle("line", centerX - 160, arrowY, arrowWidth, arrowHeight)
    if currentPage ~= 1 then
      love.graphics.printf("Prev.", centerX - 160, arrowY + arrowHeight / 4, arrowWidth, "center")
    end
    if currentPage < maxPages then
    -- love.graphics.rectangle("line", centerX + 40, arrowY, arrowWidth, arrowHeight)
    love.graphics.printf("Next", centerX + 40, arrowY + arrowHeight / 4, arrowWidth, "center")
    end
  end

  love.graphics.printf("Pagina " .. currentPage .. " di " .. maxPages, centerX - 50, screenHeight - 100, 100, "center")
end

return yearbook
