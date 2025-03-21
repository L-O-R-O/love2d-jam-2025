local constants = require("constants")

outcome = {}

function outcome.load()
  mouse.registerHandler(agenda, constants.SCENES_OUTCOME)
end

function outcome.update(dt)
end

function outcome.draw()
  -- Disegnare sfondo in base ad esito giocata
  local outcome = GameManager:getGameOutcome()

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
end

function outcome.mouseHovered(x, y)
end

return outcome
