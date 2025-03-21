local title = {}

local Menu        = require("lib.menu")
local MenuManager = require("lib.MenuManager")
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
    -- Creazione di un menu principale
    local mainMenu = Menu:new(constants.FONTS_MAIN_MENU)
    if (scenesManager.fromScene == "") then
    	mainMenu:addItem("Start Game", function()
                                        scenesManager:setScene(constants.SCENES_DESKTOP)
                                    end, nil, false, 50)
	  else
		  mainMenu:addItem("Continue", function() scenesManager:setScene(scenesManager.fromScene) end, nil, false, 50)
	  end

    mainMenu:addItem("Controls", function() mainMenu:openSubMenu("controls") end, nil, false, 50)
    mainMenu:addItem("Settings", function() mainMenu:openSubMenu("settings") end, nil, false, 50)
    mainMenu:addItem("Exit", function() love.event.quit() end)

    -- Creazione del subMenu settings
    local settingsMenu = Menu:new(constants.FONTS_SUB_MENU)
    -- local width, height = menuManager:getResolution()
    -- settingsMenu:addItem("Resolution: " .. width .. height, function() end)
    -- settingsMenu:addItem("      -- 1280x720", function()
    --                                             menuManager:setResolution(1280, 720)
    --                                             settingsMenu.items[1].name = title.updateResolutionText()
    --                                         end)
    -- settingsMenu:addItem("      -- 1920x1080", function()
    --                                                 menuManager:setResolution(1920, 1080)
    --                                                 settingsMenu.items[1].name = title.updateResolutionText()
    --                                             end, nil, false, 50)

    settingsMenu:addItem("Volume: " .. math.floor(menuManager:getVolume() * 100) .. "%",
                        function()
                            menuManager:decreaseVolume()
                            settingsMenu.items[1].name = updateVolumeText()
                        end,
                        function()
                            menuManager:increaseVolume()
                            settingsMenu.items[1].name = updateVolumeText()
                        end, true, 60)

    settingsMenu:addItem("Back", function() settingsMenu:close() end)

    -- Creazione del subMenu CONTROLLI
    local controlsMenu = Menu:new(constants.FONTS_SUB_MENU)

    controlsMenu:addItem("J - Agenda", function() end)
    controlsMenu:addItem("C - Calendar", function() end)
    controlsMenu:addItem("F - YearBook/Courses", function() end)
    controlsMenu:addItem("P - Pause", function() end)
    controlsMenu:addItem("Back", function() controlsMenu:close() end)

    -- Collegare i subMenu
    mainMenu:addSubMenu("controls", controlsMenu)
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
