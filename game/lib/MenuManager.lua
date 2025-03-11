MenuManager = {}
MenuManager.__index = MenuManager

function MenuManager:new()
    local instance = {
        volume     = 1,                           -- Volume iniziale al massimo
        resolution = {width = 800, height = 600}  -- Risoluzione predefinita
    }
    setmetatable(instance, MenuManager)
    return instance
end

-- Volume
function MenuManager:getVolume()
    return self.volume
end

function MenuManager:increaseVolume()
    self.volume = math.min(1, self.volume + 0.1)
    love.audio.setVolume(self.volume)
end

function MenuManager:decreaseVolume()
    self.volume = math.max(0, self.volume - 0.1)
    love.audio.setVolume(self.volume)
end

-- Risoluzione
function MenuManager:getResolution()
    return self.resolution.width, self.resolution.height
end

function MenuManager:setResolution(width, height)
    self.resolution.width = width
    self.resolution.height = height
    love.window.setMode(width, height, {resizable = true})
end

function love.joystickadded(joystick)
    MenuManager.joystick = joystick
    print("Controller connesso:", joystick:getName())
end

function love.joystickremoved(joystick)
    MenuManager.joystick = nil
    print("Controller scollegato")
end


return MenuManager
