local title = {}

local Menu = require("lib.menu")
local MenuManager = require("lib.MenuManager")
local desktop = require("scenes.desktop")
local constants = require("constants")

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
  if scenesManager.rebuildMenu then
    currentMenu = title.buildMenuElements()
    scenesManager.rebuildMenu = false
    currentMenu:open()
  end
end

function title.draw()
  screenManager:drawSceneBackground(constants.IMAGES_MENU_BG)
  currentMenu:draw()
end

function title.keypressed(key)
  if scenesManager:getScene() == "title" and currentMenu then
    currentMenu:keyPressed(key)
  end
end

-- Volume nel menu settings
local function updateVolumeText()
  return "Volume: " .. math.floor(menuManager:getVolume() * 100) .. "%"
end

function title.buildMenuElements()
  -- Creazione di un menu principale
  local mainMenu = Menu:new(constants.FONTS_MAIN_MENU)

  if GameManager:getOutcomeState() == constants.OUTCOMESTATE[3] or  GameManager:getOutcomeState() == constants.OUTCOMESTATE[4] then
    GameManager:reset()
    scenesManager.fromScene = ""
  end
  if scenesManager.fromScene == "" then
    mainMenu:addItem("Start Game", function()
      scenesManager:setScene(constants.SCENES_DESKTOP)
    end, nil, false, 50)
  else
    mainMenu:addItem("Continue", function()
      scenesManager:setScene(scenesManager.fromScene)
    end, nil, false, 50)
  end

  mainMenu:addItem("Settings", function()
    mainMenu:openSubMenu("settings")
  end, nil, false, 50)
  mainMenu:addItem("Credits", function()
    mainMenu:openSubMenu("credits")
  end, nil, false, 50)
  mainMenu:addItem("Exit", function()
    love.event.quit()
  end)

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

  settingsMenu:addItem("Volume: " .. math.floor(menuManager:getVolume() * 100) .. "%", function()
    menuManager:decreaseVolume()
    settingsMenu.items[1].name = updateVolumeText()
  end, function()
    menuManager:increaseVolume()
    settingsMenu.items[1].name = updateVolumeText()
  end, true, 60)

  -- Creazione del subMenu CONTROLLI
  local controlsMenu = Menu:new(constants.FONTS_SUB_MENU)
  settingsMenu:addItem("Controls", function()
    settingsMenu:openSubMenu("controls")
  end, nil, false, 50)
  controlsMenu:addItem("J - Journal", function() end)
  controlsMenu:addItem("C - Calendar", function() end)
  controlsMenu:addItem("F - YearBook", function() end)
  controlsMenu:addItem("G - Activity Calendar", function() end)
  controlsMenu:addItem("P - Menu", function() end)

  -- Creazione del subMenu Credits
  local creditsMenu = Menu:new(constants.FONTS_CREDITS_MENU)
  creditsMenu:addItem("Developed by:", function() end)
  creditsMenu:addItem("Dyd, Haxii, Daniela, Daniele, Teo", function() end)
  creditsMenu:addItem("Art by:", function() end)
  creditsMenu:addItem("Sonia", function() end)
  creditsMenu:addItem("Game design by:", function() end)
  creditsMenu:addItem("Teo, Daniela", function() end)
  creditsMenu:addItem("Music/Audio by:", function() end)
  creditsMenu:addItem("Teo", function() end)

  settingsMenu:addItem("Back", function()
    settingsMenu:close()
  end)
  controlsMenu:addItem("Back", function()
    controlsMenu:close()
  end)
  creditsMenu:addItem("Back", function()
    creditsMenu:close()
  end)

  -- Collegare i subMenu
  settingsMenu:addSubMenu("controls", controlsMenu)
  mainMenu:addSubMenu("settings", settingsMenu)
  mainMenu:addSubMenu("credits", creditsMenu)
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
