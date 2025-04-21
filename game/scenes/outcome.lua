local constants = require("constants")

outcome = {}

-- Cache delle immagini
local images = {
  session = {
    ok = constants.IMAGES_SESSION_OK,
    ko = constants.IMAGES_SESSION_KO,
    hoverOk = constants.IMAGES_SESSION_HOVER_OK,
    hoverKo = constants.IMAGES_SESSION_HOVER_KO
  },
  game = {
    ok = constants.IMAGES_GAME_OK,
    ko = constants.IMAGES_GAME_KO,
    hoverOk = constants.IMAGES_GAME_HOVER_OK,
    hoverKo = constants.IMAGES_GAME_HOVER_KO
  }
}

-- Stato della scena
local state = {
  hovered = false,
  outcomeState = nil
}

-- Aree cliccabili
local areas = {
  sessionButton = {
    xPerc = 0.37,
    yPerc = 0.83,
    widthPerc = 0.25,
    heightPerc = 0.1
  },
  gameButton = {
    xPerc = 0.55,
    yPerc = 0.25,
    widthPerc = 0.15,
    heightPerc = 0.15
  }
}

-- Funzioni di utilità
local function setupAreas()
  for name, area in pairs(areas) do
    areas[name] = screenManager:calcAreaSizes(area)
  end
end

local function okButtonHandler()
  local outcomeState = GameManager:getOutcomeState()
  if outcomeState == constants.OUTCOMESTATE[1] or outcomeState == constants.OUTCOMESTATE[2] then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif outcomeState == constants.OUTCOMESTATE[3] or outcomeState == constants.OUTCOMESTATE[4] then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

local function drawBackground(scene, sceneHovered)
  if state.hovered then
    screenManager:drawSceneBackground(sceneHovered)
  else
    screenManager:drawSceneBackground(scene)
  end
end

function outcome.load()
  mouse.registerHandler(outcome, constants.SCENES_OUTCOME)
  setupAreas()

  screenManager:setClickableArea(constants.SCENES_OUTCOME, areas.sessionButton, constants.SCENES_OUTCOME, function()
    okButtonHandler()
  end, {isSessionButton = true})

  screenManager:setClickableArea(constants.SCENES_OUTCOME, areas.gameButton, constants.SCENES_OUTCOME, function()
    okButtonHandler()
  end, {isSessionButton = false})
end

function outcome.update(dt)
  state.outcomeState = GameManager:getOutcomeState()
end

function outcome.draw()
  -- Disegnare sfondo in base ad esito giocata
  if state.outcomeState == constants.OUTCOMESTATE[1] then
    -- Session WIN
    drawBackground(images.session.ok, images.session.hoverOk)
  elseif state.outcomeState == constants.OUTCOMESTATE[2] then
    -- Session KO
    drawBackground(images.session.ko, images.session.hoverKo)
  elseif state.outcomeState == constants.OUTCOMESTATE[3] then
    -- Game WIN
    drawBackground(images.game.ok, images.game.hoverOk)
  elseif state.outcomeState == constants.OUTCOMESTATE[4] then
    -- Game KO
    drawBackground(images.game.ko, images.game.hoverKo)
  end
end

function outcome.keypressed(key)
  if key == constants.KEYS_ESCAPE_MENU then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif key == constants.KEYS_PAUSE_MENU then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function outcome.mousePressed(x, y, button)
  screenManager:click(x, y)
end

function outcome.mouseHovered(x, y)
  local clickableArea = screenManager:getClickableArea(x, y)
  if clickableArea and clickableArea.data then
    if (state.outcomeState == constants.OUTCOMESTATE[1] or state.outcomeState == constants.OUTCOMESTATE[2]) and clickableArea.data.isSessionButton == true then
      -- Session OK/KO hovered
      state.hovered = true
    elseif (state.outcomeState == constants.OUTCOMESTATE[3] or state.outcomeState == constants.OUTCOMESTATE[4]) and clickableArea.data.isSessionButton == false then
      -- Game OK/KO hovered
      state.hovered = true
    end
  else
    state.hovered = false
  end
end

return outcome
