-- https://github.com/usysrc/LICK
-- DECOMMENTARE PER USARE LICK
-- lick = require "lib.lick"
-- lick.reset = true -- ricarica love.load di main.lua ogni volta che si salva un file del progetto
-- lick.updateAllFiles = true -- include tutti i file del progetto

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
musicManager  = SoundsManager:new()

local title = require("scenes.title")
local desktop = require("scenes.desktop")
local calendar = require("scenes.calendar")
local computer = require("scenes.computer")
local agenda = require("scenes.agenda")
local tutorial = require("scenes.tutorial")
local yearBook = require("scenes.yearbook")
local courses = require("scenes.courses")
local yearBookStudentCard = require("scenes.yearbookStudentCard")
local coursesActivityCard = require("scenes.coursesActivityCard")
local outcome = require("scenes.outcome")
local confirm      = require("scenes.confirm")
local unitTest = require("lib.unitTest")
local gameOver = require("scenes.gameOver")

function love.load()
  -- DEBUG - unitTest
  --unitTest:run()

  -- Carico tutte le scene (setup iniziale)
  desktop.load()
  calendar.load()
  computer.load()
  agenda.load()
  tutorial.load()
  title.load()
  yearBook.load()
  courses.load()
  yearBookStudentCard.load()
  coursesActivityCard.load()
  outcome.load()
  confirm.load()
  gameOver.load()

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

  if scenesManager:getScene() == constants.SCENES_TITLE then
    title.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_DESKTOP then
    desktop.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_CALENDAR then
    calendar.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_YEARBOOK then
    yearBook.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_COURSES then
    courses.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_AGENDA then
    agenda.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_TUTORIAL then
    tutorial.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_YEARBOOK_STUDENT_CARD then
    yearBookStudentCard.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_COURSES_ACTIVITY_CARD then
    coursesActivityCard.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_OUTCOME then
    outcome.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_CONFIRM then
    confirm.update(dt)
  elseif scenesManager:getScene() == constants.SCENES_GAME_OVER then
    gameOver.update(dt)
  end
end

function love.draw()
  if scenesManager:getScene() == constants.SCENES_TITLE then
    title.draw()
  elseif scenesManager:getScene() == constants.SCENES_DESKTOP then
    desktop.draw()
  elseif scenesManager:getScene() == constants.SCENES_CALENDAR then
    calendar.draw()
  elseif scenesManager:getScene() == constants.SCENES_COMPUTER then
    computer.draw()
  elseif scenesManager:getScene() == constants.SCENES_YEARBOOK then
    yearBook.draw()
  elseif scenesManager:getScene() == constants.SCENES_COURSES then
    courses.draw()
  elseif scenesManager:getScene() == constants.SCENES_AGENDA then
    agenda.draw()
  elseif scenesManager:getScene() == constants.SCENES_TUTORIAL then
    tutorial.draw()
  elseif scenesManager:getScene() == constants.SCENES_YEARBOOK_STUDENT_CARD then
    yearBookStudentCard.draw()
  elseif scenesManager:getScene() == constants.SCENES_COURSES_ACTIVITY_CARD then
    coursesActivityCard.draw()
  elseif scenesManager:getScene() == constants.SCENES_OUTCOME then
    outcome.draw()
  elseif scenesManager:getScene() == constants.SCENES_CONFIRM then
    confirm.draw()
  elseif scenesManager:getScene() == constants.SCENES_GAME_OVER then
    gameOver.draw()
  end
  -- Draw transition overlay
  screenManager:draw()

  if scenesManager:getScene() == constants.SCENES_TITLE then
    return
  end

  -- Draw hearts
  local numHearts = GameManager:getHearts()
  local nPlayers = #GameManager:getGuild()
  screenManager:drawHUD(numHearts,nPlayers)
end

function love.keypressed(key)
  -- Add debug key for testing game over - REMOVE BEFORE RELEASING
 --[[ if key == "0" then -- Press 0 to instantly trigger game over
    GameManager.strikes = constants.MAX_STRIKES
    scenesManager:setScene(constants.SCENES_GAME_OVER, false) -- Add false to prevent transition
    return
  end ]]

  if scenesManager:getScene() == constants.SCENES_TITLE then
    title.keypressed(key)
  elseif (key =='c') then
    scenesManager:setScene(constants.SCENES_CALENDAR)
  elseif (key =='f') then
    scenesManager:setScene(constants.SCENES_YEARBOOK)
  elseif (key =='g') then
    scenesManager:setScene(constants.SCENES_COURSES)
  elseif (key =='j') then
    scenesManager:setScene(constants.SCENES_AGENDA)
  elseif (key =='d') then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key =='h') then
    scenesManager:setScene(constants.SCENES_TUTORIAL)
  elseif scenesManager:getScene() == constants.SCENES_DESKTOP then
    desktop.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_CALENDAR then
    calendar.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_YEARBOOK then
    yearBook.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_COURSES then
    courses.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_AGENDA then
    agenda.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_TUTORIAL then
    tutorial.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_YEARBOOK_STUDENT_CARD then
    yearBookStudentCard.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_COURSES_ACTIVITY_CARD then
    coursesActivityCard.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_OUTCOME then
    outcome.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_GAME_OVER then
    gameOver.keypressed(key)
  elseif scenesManager:getScene() == constants.SCENES_CONFIRM then
    confirm.keypressed(key)
  end
end

function onMouseHover()
  local x, y = love.mouse.getPosition()
  mouse.mouseHovered(x, y)
end

function love.mousepressed(x, y, button, istouch, presses)
  mouse.mousePressed(x, y)
end

