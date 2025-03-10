-- Importa la libreria del menu
local Menu = require("lib.menu")
local GameManager = require("lib.gameManager")

currentVolume = 1
gameManager = GameManager:new()

square = {
    x = 100,
    y = 100,
    size = 20,
    speed = 100,
    path = {{100,100}, {300,100}, {300,300}, {100,300}}, -- Percorso prefissato
    currentTarget = 1
}

-- LOVE2D callbacks
function love.load()

    local myFont_1 = love.graphics.newFont("assets/font/Hello_Sweet_Rain.ttf", 30) -- Carica il font

    -- Creazione di un menu principale
    mainMenu = Menu:new(myFont_1)
    mainMenu:addItem("Start Game", function()
                                        gameManager:setState("playing")
                                    end, nil, false, 50)
    mainMenu:addItem("Settings", function()
                                    mainMenu:openSubMenu("settings")
                                end, nil, false, 50)
    mainMenu:addItem("Exit", function() love.event.quit() end)



    -- Creazione del sottomenù settings
    local myFont_2 = love.graphics.newFont("assets/font/Hello_Sweet_Rain.ttf", 20) -- Carica il font
    settingsMenu = Menu:new(myFont_2)

    settingsMenu:addItem("Resolution: " .. gameManager:getResolution(), function() end)
    settingsMenu:addItem("      -- 800x600", function()
                                                gameManager:setResolution(800, 600)
                                                updateResolutionText()
                                            end)
    settingsMenu:addItem("      -- 1280x720", function()
                                                gameManager:setResolution(1280, 720)
                                                updateResolutionText()
                                            end)
    settingsMenu:addItem("      -- 1920x1080", function()
                                                    gameManager:setResolution(1920, 1080)
                                                    updateResolutionText()
                                                end, nil, false, 50)

    -- Volume nel menu settings
    local function updateVolumeText()
        settingsMenu.items[5].name = "Volume: " .. math.floor(gameManager:getVolume() * 100) .. "%"
    end

    settingsMenu:addItem("Volume: " .. math.floor(gameManager:getVolume() * 100) .. "%",
                        function()
                            gameManager:decreaseVolume()
                            updateVolumeText()
                        end,
                        function()
                            gameManager:increaseVolume()
                            updateVolumeText()
                        end, true, 60)

    settingsMenu:addItem("Back", function() settingsMenu:close() end)

    -- Collegare il sottomenù
    mainMenu:addSubMenu("settings", settingsMenu)

    currentMenu = mainMenu


    mainMenu:open()
end



function updateResolutionText()
    local width, height = gameManager:getResolution()
    settingsMenu.items[1].name = "Resolution: " .. width .. "x" .. height
end

function love.update(dt)
    if gameManager:getState() == 'menu' then
        currentMenu:update(dt)
    elseif gameManager:getState() == 'playing' then
        updateSquare(dt) -- Muove il quadrato solo se siamo nel gioco
    end
end

function love.draw()
    if gameManager:getState() == 'menu' then
        currentMenu:draw()
    elseif gameManager:getState() == 'playing' then
        drawGame()
    end

end

function love.keypressed(key)
    if gameManager:getState() == 'menu' then
        if currentMenu then
            currentMenu:keyPressed(key)
        end
    elseif gameManager:getState() == 'playing'then
        gameManager:setState('menu')
    end
end



function love.gamepadpressed(joystick, button)
    if gameManager:getState() == 'menu' then
        if currentMenu then
            currentMenu:gamepadpressed(joystick, button)
        end
    elseif gameManager:getState() == 'playing'then
        gameManager:setState('menu')
    end
end





function drawGame()
    love.graphics.setColor(1, 0, 0) -- Rosso
    love.graphics.rectangle("fill", square.x, square.y, square.size, square.size)
end

function updateSquare(dt)
    local target = square.path[square.currentTarget]
    local dx, dy = target[1] - square.x, target[2] - square.y
    local dist = math.sqrt(dx * dx + dy * dy)

    if dist > 1 then
        square.x = square.x + (dx / dist) * square.speed * dt
        square.y = square.y + (dy / dist) * square.speed * dt
    else
        square.currentTarget = square.currentTarget % #square.path + 1 -- Passa al prossimo punto
    end
end

