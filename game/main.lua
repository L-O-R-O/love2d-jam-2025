-- https://github.com/usysrc/LICK
-- DECOMMENTARE PER USARE LICK
-- lick = require "lib.lick"
-- lick.reset = true -- ricarica love.load di main.lua ogni volta che si salva un file del progetto
-- lick.updateAllFiles = true -- include tutti i file del progetto

local constants		  = require("constants")
GameManager         = require("lib.GameManagerDefiner")
CalendarManager     = require("lib.CalendarManager")
local ScenesManager = require("lib.scenesManager")
local ScreenManager = require("lib.screenManager")
local SoundsManager = require("lib.soundsManager")
local Mouse         = require("lib.mouse")
local Timer         = require("lib.time")

require("lib.Activity")

mouse = Mouse
timer = Timer
scenesManager = ScenesManager:new()
screenManager = ScreenManager:new()
soundsManager = SoundsManager:new()

local title    		  = require("scenes.title")
local desktop    	  = require("scenes.desktop")
local calendar 		  = require("scenes.calendar")
local computer 		  = require("scenes.computer")
local agenda   		  = require("scenes.agenda")
local yearBook      = require("scenes.yearbook")
local courses       = require("scenes.courses")
local yearBookStudentCard = require("scenes.yearbookStudentCard")
local unitTest      = require("lib.unitTest")


function loadMousePng(image)
  local canvas = love.graphics.newCanvas(constants.MOUSE_SIZE, constants.MOUSE_SIZE)
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.draw(image, 0, 0, 0, constants.MOUSE_SIZE / image:getWidth(), constants.MOUSE_SIZE / image:getHeight())
  love.graphics.setCanvas()
  local resizedImageData = canvas:newImageData()
  return resizedImageData
end

function love.load()
    -- Carico tutte le scene (setup iniziale)
    desktop.load()
    calendar.load()
    computer.load()
    agenda.load()
    title.load()
    yearBook.load()
    courses.load()
    yearBookStudentCard.load()
    -- Carico le chiavi per i cursori
    mouse.setDefaultCursorsKeys({
        default = constants.DEFAULT_CURSOR,
        hand = constants.HAND_CURSOR,
        handClicked = constants.HAND_CLICKED_CURSOR
    })
    -- Carico il cursore normale
    mouse.defaultCursorImage = loadMousePng(constants.IMAGES_CURSOR)
    -- Carico il cursore mano
    mouse.cursorHandImage = loadMousePng(constants.IMAGES_CURSOR_HAND)
    -- Carico il cursore mano cliccata
    mouse.cursorHandClickedImage = loadMousePng(constants.IMAGES_CURSOR_HAND_CLICKED)
    mouse.loadCursor(constants.DEFAULT_CURSOR);

    love.graphics.setBlendMode("alpha")  -- Ensure transparency works

    -- Play main theme
    SoundsManager.startMusic()
end

function love.update(dt)
    -- https://github.com/rxi/lurkerhttps://github.com/rxi/lurker
    -- Libreria per fare hotswap del file salvato
    -- Verranno ricaricate solo le draw ed update, NON LE LOAD
    require("lib.lurker").update()
    timer.update()
    onMouseHover()

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
      elseif scenesManager:getScene() == constants.SCENES_YEARBOOK_STUDENT_CARD then
        yearBookStudentCard.update(dt)
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
  elseif scenesManager:getScene() == constants.SCENES_YEARBOOK_STUDENT_CARD then
		yearBookStudentCard.draw()
	end
   -- Draw transition overlay
   screenManager:draw()
end

function love.keypressed(key)
    if scenesManager:getScene() == constants.SCENES_TITLE then
      title.keypressed(key)
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
    elseif scenesManager:getScene() == constants.SCENES_YEARBOOK_STUDENT_CARD then
      yearBookStudentCard.keypressed(key)
    end
end

function onMouseHover()
  local x, y = love.mouse.getPosition()
  mouse.mouseHovered(x, y)
end

function love.mousepressed(x, y, button, istouch, presses)
  mouse.mousePressed(x, y)
end








--[[
function love.load()


  unitTest:add("Calendar Manager: isFreeDay giorno libero esistente",
                function()
                  local t1 = CalendarManager:isFreeDay(1,10)
                  assert(t1 == true)
                end)

  unitTest:add("Calendar Manager: isFreeDay giorno libero inesistente",
                function()
                  local t1 = CalendarManager:isFreeDay(1,32)
                  assert(t1 == false)
                end)

  unitTest:add("Calendar Manager: isFreeDay mese inesistente",
                function()
                  local t1 = CalendarManager:isFreeDay(5,32)
                  assert(t1 == false)
                end)

unitTest:add("Activity: creo attività e mostro schedule",
                function()
                  local a1 = Activity:new('calcio', 'questo è una descrizione', {}, {1,2})
                  local s1 = a1:getStrSchedule()
                  assert(s1 == 'Every Monday and Tuesday')
                end)

unitTest:add("Activity: cambiando il mese e mostro schedulo",
                function()
                  local a1 = Activity:new('calcio', 'questo è una descrizione', {}, {1,2})
                  a1:setMonth(2)
                  local s1 = a1:getStrSchedule()
                  assert(s1 == 'Every Monday and Tuesday')
                end)

unitTest:add("Player: lo creo ed ottengo la lista delle attività",
                function()
                  local s1 = Activity:new('calcio', 'questo è una descrizione', {}, {1,2})
                  local h1 = Activity:new('chimica', 'questo è una descrizione', {}, {3,4})
                  local p1 = Player:new('Gargiulio Fagiani', 'Bravo a pescare', h1,s1,true)
                  local h2, s2 = p1:getScheduleNames()
                  assert(h2:getName() .. ' ' ..  s2:getName() == 'chimica calcio')
                end)

unitTest:add("Calendar: 2 giocatori controllo disponibilità",
                function()
                  local s1 = Activity:new('calcio', 'questo è una descrizione', {}, {1,2})
                  local h1 = Activity:new('chimica', 'questo è una descrizione', {}, {3,4})
                  local s2 = Activity:new('hokey', 'questo è una descrizione', {}, {5})
                  local h2 = Activity:new('fisica', 'questo è una descrizione', {}, {6})
                  local p1 = Player:new('Gargiulio Fagiani', 'Bravo a pescare', h1,s1,true)
                  local p2 = Player:new('Baggiani Lopiaggio', 'Bravo ad essere Bravo', h2,s2,true)

                  CalendarManager:addActivity(s1,1)
                  CalendarManager:printCalendar()
                  CalendarManager:addActivity(s2,1)
                  CalendarManager:addActivity(h1,1)
                  CalendarManager:addActivity(h2,1)
                  CalendarManager:printCalendar()


                  local t1 = CalendarManager:isFreeDay(1,7)
                  assert(t1 == true)
                end)

    -- Esegui i test
    unitTest:run()
end
]]
