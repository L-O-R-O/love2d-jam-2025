-- https://github.com/usysrc/LICK
-- DECOMMENTARE PER USARE LICK
-- lick = require "lib.lick"
-- lick.reset = true -- ricarica love.load di main.lua ogni volta che si salva un file del progetto
-- lick.updateAllFiles = true -- include tutti i file del progetto
--test pr

local constants = require("constants")
GameManager = require("lib.GameManagerDefiner")
--CalendarManager     = require("lib.CalendarManager")
local ScenesManager = require("lib.scenesManager")
local ScreenManager = require("lib.screenManager")
local SoundsManager = require("lib.soundsManager")
local MusicManager = require("lib.soundsManager")
local Mouse = require("lib.mouse")
local Timer = require("lib.time")

require("lib.Activity")

mouse = Mouse
timer = Timer
scenesManager = ScenesManager:new()
screenManager = ScreenManager:new()
soundsManager = SoundsManager:new()
musicManager = SoundsManager:new()

-- Cache delle scene
local scenes = {
    title = require("scenes.title"),
    desktop = require("scenes.desktop"),
    calendar = require("scenes.calendar"),
    computer = require("scenes.computer"),
    agenda = require("scenes.agenda"),
    tutorial = require("scenes.tutorial"),
    yearBook = require("scenes.yearbook"),
    courses = require("scenes.courses"),
    yearBookStudentCard = require("scenes.yearbookStudentCard"),
    coursesActivityCard = require("scenes.coursesActivityCard"),
    outcome = require("scenes.outcome"),
    confirm = require("scenes.confirm"),
    gameOver = require("scenes.gameOver")
}

-- Cache delle chiavi rapide per le scene
local quickSceneKeys = {
    c = constants.SCENES_CALENDAR,
    f = constants.SCENES_YEARBOOK,
    g = constants.SCENES_COURSES,
    j = constants.SCENES_AGENDA,
    d = constants.SCENES_DESKTOP,
    h = constants.SCENES_TUTORIAL
}

-- Cache dei cursori
local cursors = {
    default = constants.DEFAULT_CURSOR,
    hand = constants.HAND_CURSOR,
    handClicked = constants.HAND_CLICKED_CURSOR
}

-- Cache delle immagini dei cursori
local cursorImages = {
    default = constants.IMAGES_CURSOR,
    hand = constants.IMAGES_CURSOR_HAND,
    handClicked = constants.IMAGES_CURSOR_HAND_CLICKED
}

-- Cache delle scene per il lookup
local sceneHandlers = {
    [constants.SCENES_TITLE] = scenes.title,
    [constants.SCENES_DESKTOP] = scenes.desktop,
    [constants.SCENES_CALENDAR] = scenes.calendar,
    [constants.SCENES_COMPUTER] = scenes.computer,
    [constants.SCENES_YEARBOOK] = scenes.yearBook,
    [constants.SCENES_COURSES] = scenes.courses,
    [constants.SCENES_AGENDA] = scenes.agenda,
    [constants.SCENES_TUTORIAL] = scenes.tutorial,
    [constants.SCENES_YEARBOOK_STUDENT_CARD] = scenes.yearBookStudentCard,
    [constants.SCENES_COURSES_ACTIVITY_CARD] = scenes.coursesActivityCard,
    [constants.SCENES_OUTCOME] = scenes.outcome,
    [constants.SCENES_CONFIRM] = scenes.confirm,
    [constants.SCENES_GAME_OVER] = scenes.gameOver
}

function love.load()
  -- DEBUG - unitTest
  --unitTest:run()

  -- Carico tutte le scene (setup iniziale)
  for _, scene in pairs(scenes) do
    scene.load()
  end

  -- Carico le chiavi per i cursori
  mouse.setDefaultCursorsKeys({
    default = constants.DEFAULT_CURSOR,
    hand = constants.HAND_CURSOR,
    handClicked = constants.HAND_CLICKED_CURSOR,
  })
  -- Carico il cursore normale
  mouse.defaultCursorImage = constants.IMAGES_CURSOR
  -- Carico il cursore mano
  mouse.cursorHandImage = constants.IMAGES_CURSOR_HAND
  -- Carico il cursore mano cliccata
  mouse.cursorHandClickedImage = constants.IMAGES_CURSOR_HAND_CLICKED
  mouse.loadCursor(constants.DEFAULT_CURSOR)

  love.graphics.setBlendMode("alpha") -- Ensure transparency works

  -- Play main theme
  constants.SOUNDS_BACKGROUND_AMBIENT:setVolume(0.5)
  soundsManager:playMe(constants.SOUNDS_BACKGROUND_AMBIENT)
  musicManager:startMusic()
end

function love.update(dt)
  -- https://github.com/rxi/lurkerhttps://github.com/rxi/lurker
  -- Libreria per fare hotswap del file salvato
  -- Verranno ricaricate solo le draw ed update, NON LE LOAD
  require("lib.lurker").update()
  timer.update()
  onMouseHover()

  --[[ -- Commentato perchè non dovrebbe stare qui
  if GameManager:getHearts() >= constants.MAX_HEARTS and scenesManager:getScene() ~= constants.SCENES_GAME_OVER then
    scenesManager:setScene(constants.SCENES_GAME_OVER, false) -- Add false to prevent transition
    return -- Add return to prevent further updates this frame
  end
  ]]

  -- Update transition effect
  screenManager:update(dt, scenesManager)

  -- Update current scene
  local currentScene = scenesManager:getScene()
  local sceneHandler = sceneHandlers[currentScene]
  if sceneHandler and sceneHandler.update then
    sceneHandler.update(dt)
  end
end

function love.draw()
  -- Draw current scene
  local currentScene = scenesManager:getScene()
  local sceneHandler = sceneHandlers[currentScene]
  if sceneHandler and sceneHandler.draw then
    sceneHandler.draw()
  end

  -- Draw transition overlay
  screenManager:draw()

  if currentScene == constants.SCENES_TITLE then
    return
  end

  -- Draw hearts
  local numHearts = GameManager:getHearts()
  local nPlayers = #GameManager:getGuild()
  screenManager:drawHUD(numHearts, nPlayers)
end

function love.keypressed(key)
  -- Add debug key for testing game over - REMOVE BEFORE RELEASING
  --[[ if key == "0" then -- Press 0 to instantly trigger game over
    GameManager.strikes = constants.MAX_STRIKES
    scenesManager:setScene(constants.SCENES_GAME_OVER, false) -- Add false to prevent transition
    return
  end ]]

  local currentScene = scenesManager:getScene()

  -- Handle quick scene transitions
  if quickSceneKeys[key] then
    scenesManager:setScene(quickSceneKeys[key])
    return
  end

  -- Handle scene-specific key presses
  local sceneHandler = sceneHandlers[currentScene]
  if sceneHandler and sceneHandler.keypressed then
    sceneHandler.keypressed(key)
  end
end

function onMouseHover()
  local x, y = love.mouse.getPosition()
  mouse.mouseHovered(x, y)
end

function love.mousepressed(x, y, button, istouch, presses)
  mouse.mousePressed(x, y)
end

