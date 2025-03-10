GameManager = {}
GameManager.__index = GameManager

function GameManager:new()
    local instance = {
        state = "menu",  -- Stato iniziale
        volume = 1,  -- Volume iniziale al massimo
        resolution = {width = 800, height = 600}  -- Risoluzione predefinita
    }
    setmetatable(instance, GameManager)
    return instance
end

-- Cambiare stato del gioco
function GameManager:getState()
    return self.state
end

function GameManager:setState(newState)
    self.state = newState
end

-- Volume
function GameManager:getVolume()
    return self.volume
end

function GameManager:increaseVolume()
    self.volume = math.min(1, self.volume + 0.1)
    love.audio.setVolume(self.volume)
end

function GameManager:decreaseVolume()
    self.volume = math.max(0, self.volume - 0.1)
    love.audio.setVolume(self.volume)
end

-- Risoluzione
function GameManager:getResolution()
    return self.resolution.width, self.resolution.height
end

function GameManager:setResolution(width, height)
    self.resolution.width = width
    self.resolution.height = height
    love.window.setMode(width, height, {resizable = true})
end

function love.joystickadded(joystick)
    gameManager.joystick = joystick
    print("Controller connesso:", joystick:getName())
end

function love.joystickremoved(joystick)
    gameManager.joystick = nil
    print("Controller scollegato")
end


return GameManager
