-- require("lldebugger").start()
local StatesManager = require("lib.StatesManager")
local title  = require("states.title")
local world  = require("states.world")

statesManager = StatesManager:new()
currentState = statesManager:getState() -- Stato iniziale

function love.load()
    title.load()
    love.graphics.setBlendMode("alpha")  -- Ensure transparency works
end

function love.update(dt)
    if statesManager:getState() == "title" then
        title.update(dt)
    elseif statesManager:getState() == "world" then
        world.update(dt)
    end
end

function love.draw()
    if statesManager:getState() == "title" then
        title.draw()
    elseif statesManager:getState() == "world" then
        world.draw()
    end
end

function love.keypressed(key)
    if statesManager:getState() == 'title' then
        title.keypressed(key)
    elseif statesManager:getState() == 'world' then
        world.keypressed(key)
    end
end

function love.gamepadpressed(joystick, button)
    if statesManager:getState() == 'title' then
        title.gamepadpressed(joystick, button)
    elseif statesManager:getState() == 'world' then
        world.gamepadpressed(joystick, button)
    end
end

