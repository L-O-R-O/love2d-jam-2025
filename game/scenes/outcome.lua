local constants = require("constants")

outcome = {}
local okButtonArea = {}

-- Il click su OK ci porterá su una scena diversa, in base all'esito della giocata

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
  okButtonArea = screenManager:calcAreaSizes({
    xPerc = 0.45,
    yPerc = 0.7,
    widthPerc = 0.1,
    heightPerc = 0.1
  })

  screenManager:setClickableArea(constants.SCENES_OUTCOME, okButtonArea, constants.SCENES_OUTCOME, function()
    okButtonHandler()
  end)
end

function outcome.update(dt)
end

function outcome.draw()
  -- love.graphics.rectangle("line",okButtonArea.x,okButtonArea.y,okButtonArea.width,okButtonArea.height)

  -- Disegnare sfondo in base ad esito giocata
  local outcome = GameManager:getOutcomeState()

  if outcome == constants.OUTCOMESTATE[1] then
    -- -- Session WIN
    screenManager:drawSceneBackground(constants.IMAGES_SESSION_OK)
  elseif outcome == constants.OUTCOMESTATE[2] then
    -- Session KO
    screenManager:drawSceneBackground(constants.IMAGES_SESSION_KO)
  elseif outcome == constants.OUTCOMESTATE[3] then
    -- Game WIN
    screenManager:drawSceneBackground(constants.IMAGES_GAME_OK)
  elseif outcome == constants.OUTCOMESTATE[4] then
    -- Game KO
    screenManager:drawSceneBackground(constants.IMAGES_GAME_KO)
  end

  love.graphics.printf(
    "OK",
    okButtonArea.x,
    okButtonArea.y + (okButtonArea.height / 4),
    okButtonArea.width,
    "center"
  )
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
end

return outcome
