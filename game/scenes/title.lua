local title = {}

local Menu        = require("lib.menu")
local MenuManager = require("lib.menuManager")
local desktop     = require("scenes.desktop")
local constants   = require("constants")

menuManager = MenuManager:new()

function title.load()
    mouse.registerHandler(title, constants.SCENES_TITLE)
    currentMenu = title.buildMenuElements()
    currentMenu:open()
end

function title.updateResolutionText()
    local width, height = menuManager:getResolution()
    return "Resolution: " .. width .. "x" .. height
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
    end
end

-- Volume nel menu settings
local function updateVolumeText()
    return "Volume: " .. math.floor(menuManager:getVolume() * 100) .. "%"
end

function title.buildMenuElements()
    local myFont_1 = constants.FONTS_MAIN_MENU -- Carica il font

    -- Creazione di un menu principale
    local mainMenu = Menu:new(myFont_1)
    if (scenesManager.fromScene == "") then
    	mainMenu:addItem("Start Game", function()
                                        scenesManager:setScene(constants.SCENES_DESKTOP)
                                    end, nil, false, 50)
	  else
		  mainMenu:addItem("Continue", function() scenesManager:setScene(scenesManager.fromScene) end, nil, false, 50)
	  end

    mainMenu:addItem("Settings", function() mainMenu:openSubMenu("settings") end, nil, false, 50)
    mainMenu:addItem("Exit", function() love.event.quit() end)

    -- Creazione del sottomenù settings
    local myFont_2 = constants.FONTS_SUB_MENU -- Carica il font
    local settingsMenu = Menu:new(myFont_2)

    settingsMenu:addItem("Resolution: " .. menuManager:getResolution(), function() end)
    settingsMenu:addItem("      -- 800x600", function()
                                                menuManager:setResolution(800, 600)
                                                settingsMenu.items[1].name = title.updateResolutionText()
                                            end)
    settingsMenu:addItem("      -- 1280x720", function()
                                                menuManager:setResolution(1280, 720)
                                                settingsMenu.items[1].name = title.updateResolutionText()
                                            end)
    settingsMenu:addItem("      -- 1920x1080", function()
                                                    menuManager:setResolution(1920, 1080)
                                                    settingsMenu.items[1].name = title.updateResolutionText()
                                                end, nil, false, 50)

    settingsMenu:addItem("Volume: " .. math.floor(menuManager:getVolume() * 100) .. "%",
                        function()
                            menuManager:decreaseVolume()
                            settingsMenu.items[5].name = updateVolumeText()
                        end,
                        function()
                            menuManager:increaseVolume()
                            settingsMenu.items[5].name = updateVolumeText()
                        end, true, 60)

    settingsMenu:addItem("Back", function() settingsMenu:close() end)

    -- Collegare il sottomenù
    mainMenu:addSubMenu("settings", settingsMenu)
    return mainMenu
end

function title.mousePressed(x, y, button)
    if currentMenu then
        currentMenu:mousePressed(x, y)
    end
end

function title.mouseHovered(x, y)
    if currentMenu then
        currentMenu:mouseHovered(x, y)
    end
end

return title
