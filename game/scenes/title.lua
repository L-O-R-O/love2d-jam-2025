local title = {}
-- Importa la libreria del menu
local Menu        = require("lib.menu")
local MenuManager = require("lib.menuManager")
local desktop     = require("scenes.desktop")
local constants   = require("constants")

currentVolume = 1
menuManager = MenuManager:new()

-- LOVE2D callbacks
function title.load()
    currentMenu = title.buildMenuElements()
    currentMenu:open()
end

function updateResolutionText()
    local width, height = menuManager:getResolution()
    settingsMenu.items[1].name = "Resolution: " .. width .. "x" .. height
end

function title.update(dt)
    currentMenu:update(dt)
    if (scenesManager.rebuildMenu) then
        currentMenu = title.buildMenuElements()
        scenesManager.rebuildMenu = false
        currentMenu:open()
    end
end

function title.draw()
    currentMenu:draw()
end

function title.keypressed(key)
    if scenesManager:getScene() == 'title' then
        if currentMenu then
            currentMenu:keyPressed(key)
        end
    elseif scenesManager:getScene() == 'world' then
        scenesManager:setScene('title')
    end
end

function title.gamepadpressed(joystick, button)
    if scenesManager:getScene() == 'title' then
        if currentMenu then
            currentMenu:gamepadpressed(joystick, button)
        end
    elseif scenesManager:getScene() == 'world' then
        scenesManager:setScene('title')
    end
end

function title.buildMenuElements()
    local myFont_1 = constants.MAIN_MENU_FONT -- Carica il font

    -- Creazione di un menu principale
    local mainMenu = Menu:new(myFont_1)
    if (scenesManager.fromScene == "") then
    	mainMenu:addItem("Start Game", function()
                                        scenesManager:setScene(constants.SCENES_DESKTOP)
                                        desktop.load()
                                    end, nil, false, 50)
	else
		mainMenu:addItem("Continue", function() scenesManager:setScene(scenesManager.fromScene) end, nil, false, 50)
	end

    mainMenu:addItem("Settings", function() mainMenu:openSubMenu("settings") end, nil, false, 50)
    mainMenu:addItem("Exit", function() love.event.quit() end)

    -- Creazione del sottomenù settings
    local myFont_2 = constants.SUB_MENU_FONT -- Carica il font
    local settingsMenu = Menu:new(myFont_2)

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
    return mainMenu
end

-- Volume nel menu settings
function updateVolumeText()
    settingsMenu.items[5].name = "Volume: " .. math.floor(menuManager:getVolume() * 100) .. "%"
end

return title
