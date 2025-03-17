-- https://github.com/usysrc/LICK
-- DECOMMENTARE PER USARE LICK
-- lick = require "lib.lick"
-- lick.reset = true -- ricarica love.load di main.lua ogni volta che si salva un file del progetto
-- lick.updateAllFiles = true -- include tutti i file del progetto

local ScenesManager = require("lib.scenesManager")
local ScreenManager = require("lib.screenManager")
local Mouse = require("lib.mouse")
local constants		  = require("constants")
local Timer = require("lib.time")

local title    		  = require("scenes.title")
local desktop    	  = require("scenes.desktop")
local calendar 		  = require("scenes.calendar")
local computer 		  = require("scenes.computer")
local agenda   		  = require("scenes.agenda")

mouse = Mouse
timer = Timer
scenesManager = ScenesManager:new()
screenManager = ScreenManager:new()

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

    -- Carico l'audio del click del mouse
    sound = constants.SOUNDS_MOUSE_CLICK
    love.graphics.setBlendMode("alpha")  -- Ensure transparency works
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
    elseif scenesManager:getScene() == constants.SCENES_COMPUTER then
        computer.update(dt)
    elseif scenesManager:getScene() == constants.SCENES_AGENDA then
        agenda.update(dt)
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
	elseif scenesManager:getScene() == constants.SCENES_AGENDA then
		agenda.draw()
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
    elseif scenesManager:getScene() == constants.SCENES_COMPUTER then
        computer.keypressed(key)
    elseif scenesManager:getScene() == constants.SCENES_AGENDA then
        agenda.keypressed(key)
    end
end

function onMouseHover()
  local x, y = love.mouse.getPosition()
  mouse.mouseHovered(x, y)
end

function love.mousepressed(x, y, button, istouch, presses)
  sound:play()
  mouse.mousePressed(x, y)
end

