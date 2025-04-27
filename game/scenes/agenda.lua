local constants = require("constants")

agenda = {}

-- Cache delle immagini di sfondo
local backgroundImages = {
    [3] = constants.IMAGES_AGENDA_BG_FULL,
    [2] = constants.IMAGES_AGENDA_BG_STRIKE_1,
    [1] = constants.IMAGES_AGENDA_BG_STRIKE_2
}

-- Cache dei colori
local colors = {
    blue = {0, 0, 1},
    white = {1, 1, 1}
}

-- Cache delle dimensioni dell'area dell'agenda
local agendaAreaDimensions = {
    xPerc = 0.17,
    yPerc = 0.15,
    widthPerc = 0.65,
    heightPerc = 0.77
}

-- Cache delle dimensioni della griglia
local gridDimensions = {
    columnWidth = 200,
    rowHeight = 75,
    startX = 430,
    startY = 480,
    nameOffsetX = 100
}

-- Cache dello stato
local state = {
    agendaArea = {},
    guilders = {},
    hearts = 0
}

-- Cache dei giocatori (dati statici)
local players = {
  {
    name = "Alice",
    description = "A curious explorer",
    hobby = "Painting",
    sport = "Tennis",
    inGuild = true,
    avatar = "assets/avatars/alice.png"
  },
  {
    name = "Bob",
    description = "A tech enthusiast",
    hobby = "Coding",
    sport = "Basketball",
    inGuild = false,
    avatar = "assets/avatars/bob.png"
  },
  {
    name = "Charlie",
    description = "A nature lover",
    hobby = "Hiking",
    sport = "Soccer",
    inGuild = true,
    avatar = "assets/avatars/charlie.png"
  },
  {
    name = "Diana",
    description = "A bookworm",
    hobby = "Reading",
    sport = "Swimming",
    inGuild = false,
    avatar = "assets/avatars/diana.png"
  },
  {
    name = "Eve",
    description = "A music enthusiast",
    hobby = "Guitar",
    sport = "Volleyball",
    inGuild = true,
    avatar = "assets/avatars/eve.png"
  },
  {
    name = "Frank",
    description = "A gaming pro",
    hobby = "Gaming",
    sport = "Baseball",
    inGuild = false,
    avatar = "assets/avatars/frank.png"
  },
  {
    name = "Grace",
    description = "A creative artist",
    hobby = "Sketching",
    sport = "Badminton",
    inGuild = true,
    avatar = "assets/avatars/grace.png"
  }
}

-- Funzioni di utilità
local function getHearts()
  return GameManager:getHearts()
end

local function updateGuilders()
  local gameManagerGuilders = GameManager:getGuild()
  local numberOfManagerGuilders = #gameManagerGuilders

  -- Ridimensiona la tabella dei guilders se necessario
  if #state.guilders < numberOfManagerGuilders then
    for i = #state.guilders + 1, numberOfManagerGuilders do
      state.guilders[i] = ""
    end
  elseif #state.guilders > numberOfManagerGuilders then
    for i = numberOfManagerGuilders + 1, #state.guilders do
      state.guilders[i] = nil
    end
  end

  -- Aggiorna i nomi dei guilders
  for i = 1, numberOfManagerGuilders do
    local nomeCompleto = gameManagerGuilders[i]:getName()
    local posizioneSpazio = nomeCompleto:find(" ")
    state.guilders[i] = string.sub(nomeCompleto, 1, posizioneSpazio)
  end
end

local function drawPlayerName(player, index)
  local column = (index - 1) % 2
  local row = math.floor((index - 1) / 2)
  local x = gridDimensions.startX + column * gridDimensions.columnWidth
  local y = gridDimensions.startY + row * gridDimensions.rowHeight

  love.graphics.setColor(colors.white)
  love.graphics.print(player, x + gridDimensions.nameOffsetX, y)
end

-- LOVE FUNCTIONS
function agenda.load()
  mouse.registerHandler(agenda, constants.SCENES_AGENDA)
  -- Calcola l'area dell'agenda una sola volta
  state.agendaArea = screenManager:calcAreaSizes(agendaAreaDimensions)
end

function agenda.update(dt)
  -- Aggiorna i cuori solo se necessario
  state.hearts = getHearts()
  updateGuilders()
end

function agenda.draw()
  -- Imposta il font
  love.graphics.setFont(constants.FONTS_NICE_CHALK_AGENDA)

  -- Disegna lo sfondo in base ai cuori
  local bgImage = backgroundImages[state.hearts] or backgroundImages[1]
  screenManager:drawSceneBackground(bgImage)

  -- Disegna l'area dell'agenda (debug)
  -- love.graphics.setColor(colors.blue)
  -- love.graphics.rectangle("line", state.agendaArea.x, state.agendaArea.y, state.agendaArea.width, state.agendaArea.height)

  -- Disegna i nomi dei giocatori
  love.graphics.setColor(colors.white)
  for i, player in ipairs(state.guilders) do
    drawPlayerName(player, i)
  end

  -- Ripristina il colore
  love.graphics.setColor(colors.white)
end

function agenda.keypressed(key)
  if key == constants.KEYS_ESCAPE_MENU then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif key == constants.KEYS_PAUSE_MENU then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function agenda.mousePressed(x, y, button)
  if screenManager:checkIfClickingOutside(x, y, state.agendaArea) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  end
end

function agenda.mouseHovered(x, y)
  -- Implementazione vuota ma mantenuta per coerenza
end

return agenda
