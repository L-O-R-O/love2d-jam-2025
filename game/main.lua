-- https://github.com/usysrc/LICK
-- DECOMMENTARE PER USARE LICK
-- lick = require "lib.lick"
-- lick.reset = true -- ricarica love.load di main.lua ogni volta che si salva un file del progetto
-- lick.updateAllFiles = true -- include tutti i file del progetto

local ScenesManager = require("lib.scenesManager")
local constants		  = require("constants")

local title    		  = require("scenes.title")
local desktop    	  = require("scenes.desktop")
local calendar 		  = require("scenes.calendar")
local computer 		  = require("scenes.computer")
local agenda   		  = require("scenes.agenda")

scenesManager = ScenesManager:new()
currentState = scenesManager:getState() -- Stato iniziale

function love.load()
    title.load()
    love.graphics.setBlendMode("alpha")  -- Ensure transparency works
end

function love.update(dt)
    -- https://github.com/rxi/lurkerhttps://github.com/rxi/lurker
    -- Libreria per fare hotswap del file salvato
    -- Verranno ricaricate solo le draw ed update, NON LE LOAD
    require("lib.lurker").update()
    if scenesManager:getState() == "title" then
      title.update(dt)
    elseif scenesManager:getState() == constants.SCENES_DESKTOP then
      desktop.update(dt)
    elseif scenesManager:getState() == constants.SCENES_CALENDAR then
        calendar.update(dt)
    elseif scenesManager:getState() == constants.SCENES_COMPUTER then
        computer.update(dt)
    elseif scenesManager:getState() == "agenda" then
        agenda.update(dt)
    end
end

function love.draw()
    if scenesManager:getState() == "title" then
		title.draw()
	elseif scenesManager:getState() == constants.SCENES_DESKTOP then
		desktop.draw()
	elseif scenesManager:getState() == constants.SCENES_CALENDAR then
		calendar.draw()
	elseif scenesManager:getState() == constants.SCENES_COMPUTER then
		computer.draw()
	elseif scenesManager:getState() == "agenda" then
		agenda.draw()
	end
end

function love.keypressed(key)
    if scenesManager:getState() == "title" then
        title.keypressed(key)
    elseif scenesManager:getState() == constants.SCENES_DESKTOP then
        desktop.keypressed(key)
    elseif scenesManager:getState() == constants.SCENES_CALENDAR then
        calendar.keypressed(key)
    elseif scenesManager:getState() == constants.SCENES_COMPUTER then
        computer.keypressed(key)
    elseif scenesManager:getState() == "agenda" then
        agenda.keypressed(key)
    end
end

