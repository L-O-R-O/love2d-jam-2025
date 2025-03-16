-- https://github.com/usysrc/LICK
-- DECOMMENTARE PER USARE LICK
-- lick = require "lib.lick"
-- lick.reset = true -- ricarica love.load di main.lua ogni volta che si salva un file del progetto
-- lick.updateAllFiles = true -- include tutti i file del progetto

local ScenesManager = require("lib.scenesManager")
local ScreenManager = require("lib.screenManager")
local Mouse = require("lib.mouse")
local constants		  = require("constants")

local title    		  = require("scenes.title")
local desktop    	  = require("scenes.desktop")
local calendar 		  = require("scenes.calendar")
local computer 		  = require("scenes.computer")
local agenda   		  = require("scenes.agenda")

mouse = Mouse
scenesManager = ScenesManager:new()
screenManager = ScreenManager:new()

function love.load()
    -- Carico tutte le scene (setup iniziale)
    desktop.load()
    calendar.load()
    computer.load()
    agenda.load()
    title.load()
    mouse.loadCursor("assets/images/cursor.png", 64,64);
    love.graphics.setBlendMode("alpha")  -- Ensure transparency works
end

function love.update(dt)
    -- https://github.com/rxi/lurkerhttps://github.com/rxi/lurker
    -- Libreria per fare hotswap del file salvato
    -- Verranno ricaricate solo le draw ed update, NON LE LOAD
    require("lib.lurker").update()
    onMouseHover()
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
  mouse.mousePressed(x, y)
end

