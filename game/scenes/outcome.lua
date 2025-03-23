local constants = require("constants")

outcome = {}
local hovered = false
local sessionButtonArea = {}
local gameButtonArea = {}

local function okButtonHandler()
  local outcome = GameManager:getOutcomeState()
  if outcome == constants.OUTCOMESTATE[1] or outcome == constants.OUTCOMESTATE[2] then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif outcome == constants.OUTCOMESTATE[3] or outcome == constants.OUTCOMESTATE[4] then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function outcome.load()
  mouse.registerHandler(outcome, constants.SCENES_OUTCOME)
  sessionButtonArea = screenManager:calcAreaSizes({
    xPerc = 0.37,
    yPerc = 0.83,
    widthPerc = 0.25,
    heightPerc = 0.1
  })

  screenManager:setClickableArea(constants.SCENES_OUTCOME, sessionButtonArea, constants.SCENES_OUTCOME, function()
    okButtonHandler()
  end, {isSessionButton = true})

  gameButtonArea = screenManager:calcAreaSizes({
    xPerc = 0.55,
    yPerc = 0.25,
    widthPerc = 0.15,
    heightPerc = 0.15
  })

  screenManager:setClickableArea(constants.SCENES_OUTCOME, gameButtonArea, constants.SCENES_OUTCOME, function()
    okButtonHandler()
  end, {isSessionButton = false})
end

function outcome.update(dt)
end

function drawBackground(scene, sceneHovered)
  if (hovered) then
    screenManager:drawSceneBackground(sceneHovered)
  else
    screenManager:drawSceneBackground(scene)
  end
end

function outcome.draw()
  -- Disegnare sfondo in base ad esito giocata
  local outcome = GameManager:getOutcomeState()

  if outcome == constants.OUTCOMESTATE[1] then
    -- Session WIN
    drawBackground(constants.IMAGES_SESSION_OK, constants.IMAGES_SESSION_HOVER_OK)
  elseif outcome == constants.OUTCOMESTATE[2] then
    -- Session KO
    drawBackground(constants.IMAGES_SESSION_KO, constants.IMAGES_SESSION_HOVER_KO)
  elseif outcome == constants.OUTCOMESTATE[3] then
    -- Game WIN
    drawBackground(constants.IMAGES_GAME_OK, constants.IMAGES_GAME_HOVER_OK)
  elseif outcome == constants.OUTCOMESTATE[4] then
    -- Game KO
    drawBackground(constants.IMAGES_GAME_KO, constants.IMAGES_GAME_HOVER_KO)
  end
end

function outcome.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function outcome.mousePressed(x, y, button)
  screenManager:checkIfIsClickable(x, y)
end

function outcome.mouseHovered(x, y)
  local clickableArea = screenManager:checkIfIsClickable(x, y, "hover")
  if (clickableArea and clickableArea.data) then
    local outcome = GameManager:getOutcomeState()
    print('Outcome: ', outcome)
    print('clickableArea.data.isSessionButton: ', clickableArea.data.isSessionButton)
    if ((outcome == constants.OUTCOMESTATE[1] or outcome == constants.OUTCOMESTATE[2]) and clickableArea.data.isSessionButton == true) then
      -- Session OK/KO hovered
      hovered = true
    elseif (outcome == constants.OUTCOMESTATE[3] or outcome == constants.OUTCOMESTATE[4] and clickableArea.data.isSessionButton == false) then
      -- Game OK/KO hovered
      hovered = true
    end
  else
    hovered = false
  end
end

return outcome
