local constants = require("constants")

outcome = {}
local okButtonArea = {}

-- Il click su OK ci porterá su una scena diversa, in base all'esito della giocata

local function okButtonHandler()
  -- Navigo su title se GAME WIN - GAME OVER
  -- Navigo su DESKTOP se SESSIONE WIN -- SESSION OVER
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
  love.graphics.rectangle("line",okButtonArea.x,okButtonArea.y,okButtonArea.width,okButtonArea.height)

  -- Disegnare sfondo in base ad esito giocata
  local outcome = GameManager:getOutcomeState()

  print("Outcome: " .. outcome)

  if outcome == constants.OUTCOMESTATE[1] then
    -- -- Session WIN
    -- screenManager:drawSceneBackground(constants.IMAGES_OUTCOME_WIN_SESSION)
  elseif outcome == constants.OUTCOMESTATE[2] then
    -- Session KO
    -- screenManager:drawSceneBackground(constants.IMAGES_OUTCOME_LOSE_SESSION)
  elseif outcome == constants.OUTCOMESTATE[3] then
    -- Game WIN
    -- screenManager:drawSceneBackground(constants.IMAGES_OUTCOME_LOSE_GAME)
  elseif outcome == constants.OUTCOMESTATE[4] then
    -- Game KO
    -- screenManager:drawSceneBackground(constants.IMAGES_OUTCOME_WIN_GAME)
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
end

return outcome
