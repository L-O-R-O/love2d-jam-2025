local title = {}
-- Importa la libreria del menu
local Menu        = require("lib.menu")
local MenuManager = require("lib.menuManager")
local world       = require("states.world")
local constants    = require("constants")

currentVolume = 1
menuManager = MenuManager:new()

-- LOVE2D callbacks
function title.load()

    local myFont_1 = constants.main_menu_font -- Carica il font

    -- Creazione di un menu principale
    mainMenu = Menu:new(myFont_1)
    mainMenu:addItem("Start Game", function()
                                        statesManager:setState("world")
                                        world.load()
                                    end, nil, false, 50)
    mainMenu:addItem("Settings", function()
                                    mainMenu:openSubMenu("settings")
                                end, nil, false, 50)
    mainMenu:addItem("Exit", function() love.event.quit() end)

    -- Creazione del sottomenù settings
    local myFont_2 = constants.sub_menu_font -- Carica il font
    settingsMenu = Menu:new(myFont_2)

    settingsMenu:addItem("Resolution: " .. menuManager:getResolution(), function() end)
    settingsMenu:addItem("      -- 800x600", function()
                                                menuManager:setResolution(800, 600)
                                                updateResolutionText()
                                            end)
    settingsMenu:addItem("      -- 1280x720", function()
                                                menuManager:setResolution(1280, 720)
                                                updateResolutionText()
                                            end)
    settingsMenu:addItem("      -- 1920x1080", function()
                                                    menuManager:setResolution(1920, 1080)
                                                    updateResolutionText()
                                                end, nil, false, 50)

    -- Volume nel menu settings
    local function updateVolumeText()
        settingsMenu.items[5].name = "Volume: " .. math.floor(menuManager:getVolume() * 100) .. "%"
    end

    settingsMenu:addItem("Volume: " .. math.floor(menuManager:getVolume() * 100) .. "%",
                        function()
                            menuManager:decreaseVolume()
                            updateVolumeText()
                        end,
                        function()
                            menuManager:increaseVolume()
                            updateVolumeText()
                        end, true, 60)

    settingsMenu:addItem("Back", function() settingsMenu:close() end)

    -- Collegare il sottomenù
    mainMenu:addSubMenu("settings", settingsMenu)

    currentMenu = mainMenu


    mainMenu:open()
end

function updateResolutionText()
    local width, height = menuManager:getResolution()
    settingsMenu.items[1].name = "Resolution: " .. width .. "x" .. height
end

function title.update(dt)
    --[[ if menuManager:getState() == 'menu' then
        currentMenu:update(dt)
    elseif menuManager:getState() == 'world' then
        updateSquare(dt) -- Muove il quadrato solo se siamo nel gioco
    end ]]
    currentMenu:update(dt)
end

function title.draw()
    --[[ if menuManager:getState() == 'menu' then
        currentMenu:draw()
    elseif menuManager:getState() == 'world' then
        drawGame()
    end ]]
    currentMenu:draw()
end

function title.keypressed(key)
    if statesManager:getState() == 'title' then
        if currentMenu then
            currentMenu:keyPressed(key)
        end
    elseif statesManager:getState() == 'world' then
        statesManager:setState('title')
    end
end

function title.gamepadpressed(joystick, button)
    if statesManager:getState() == 'title' then
        if currentMenu then
            currentMenu:gamepadpressed(joystick, button)
        end
    elseif statesManager:getState() == 'world' then
        statesManager:setState('title')
    end
end

return title
