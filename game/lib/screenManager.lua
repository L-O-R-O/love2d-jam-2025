local constants = require("constants")

ScreenManager = {}
ScreenManager.__index = ScreenManager

function ScreenManager:new()
  local properties = {
    screenWidth = love.graphics.getWidth(),
    screenHeight = love.graphics.getHeight(),
    resizeAllAreas = false,
    areas = {},
    fadeAlpha = 0, -- Controls the transition effect
    isTransitioning = false,
    transitionSpeed = 7, -- Adjust speed for faster/slower fade
    nextScene = nil,
  }
  setmetatable(properties, ScreenManager)
  return properties
end

function ScreenManager:setResolution(w, h)
  self.screenWidth = w
  self.screenHeight = h
  self.resizeAllAreas = true
  love.window.setMode(w, h, { resizable = false })
end

--- Aggiunge un'area cliccabile
---@param from Scena di partenza
---@param area Area cliccabile
---@param to Scena di destinazione
---@param handler Funzione da eseguire al click dell'area
function ScreenManager:setClickableArea(from, area, to, handler, data)
  area = self:calcAreaSizes(area)

  if self.areas[from] == nil then
    self.areas[from] = {}
  end

  table.insert(self.areas[from], { area = area, to = to, handler = handler, data = data })
  return area
end

function ScreenManager:drawHearts(hearts)
  local imageWidth, imageHeight = 60, 60 -- Dimensions of each image
  local padding = 20 -- Padding between images and from the left side

  for i = 1, hearts do
    local x = padding + (i - 1) * (imageWidth + padding)
    local y = padding
    love.graphics.draw(constants.IMAGES_HEART, x, y, 0, imageWidth / constants.IMAGES_HEART:getWidth(), imageHeight / constants.IMAGES_HEART:getHeight())
  end
end

function ScreenManager:calcAreaSizes(area)
  area.x = self.screenWidth * area.xPerc
  area.y = self.screenHeight * area.yPerc
  area.width = self.screenWidth * area.widthPerc
  area.height = self.screenHeight * area.heightPerc
  return area
end

function ScreenManager:calcRelativeArea(parentArea, relativeArea)
  local area = {}
  area.x = parentArea.x + (parentArea.width * relativeArea.xPerc)
  area.y = parentArea.y + (parentArea.height * relativeArea.yPerc)
  area.width = parentArea.width * relativeArea.widthPerc
  area.height = parentArea.height * relativeArea.heightPerc
  return area
end

-- Controlla se un'area di una certa scena é cliccabile o meno
-- Inoltre restituisce la landing zone (nome scena) del click (se presente)
function ScreenManager:checkIfIsClickable(x, y, mode)
  local scene = scenesManager:getScene()
  if self.areas == nil then
    return nil
  end
  for _, areaOwner in ipairs(self.areas[scene]) do
    local area = areaOwner.area
    if x >= area.x and x <= area.x + area.width and y >= area.y and y <= area.y + area.height then
      if areaOwner.handler ~= nil and mode ~= "hover" then
        -- Se fornito in precedenza, viene eseguito un handler (in caso di bottone selezionato)
        areaOwner.handler()
      end
      return areaOwner
    end
  end
  -- end
  return nil
end

function ScreenManager:checkIfClickingOutside(x,y,insideArea)
  local clickedOutside = false
  if (x < insideArea.x or x > (insideArea.x + insideArea.width) or y < insideArea.y or y > (insideArea.y + insideArea.height)) then
    clickedOutside = true
  end
  return clickedOutside
end

function ScreenManager:setScene(scene)
  if self.isTransitioning then
    return
  end

  self.nextScene = scene
  self.isTransitioning = true
  self.fadeAlpha = 0 -- Start fade-in
end

-- Update transition effect
function ScreenManager:update(dt, scenesManager)
  if self.isTransitioning then
    self.fadeAlpha = self.fadeAlpha + self.transitionSpeed * dt

    if self.fadeAlpha >= 1 and self.nextScene then
      -- Switch to the new scene at full black
      scenesManager.scene = self.nextScene
      self.nextScene = nil
    end

    if self.fadeAlpha >= 2 then
      -- Fade-in completed, reset transition
      self.isTransitioning = false
      self.fadeAlpha = 0
    end
  end
end


function ScreenManager:drawSceneBackground(img, hoverImages)
  -- Background
  local imgWidth, imgHeight = img:getWidth(), img:getHeight()
  local scaleX = self.screenWidth / imgWidth
  local scaleY = self.screenHeight / imgHeight
  love.graphics.draw(img, 0, 0, 0, scaleX, scaleY)
  -- Hovers
  if isHovered and hoverImages ~= nil and hoveredArea ~= nil then
    if hoverImages[hoveredArea] ~= nil then
      local overlayImg = hoverImages[hoveredArea]
      local hoveredImgWidth, hoveredImgHeight = overlayImg:getWidth(), overlayImg:getHeight()
      local scaleX = self.screenWidth / hoveredImgWidth
      local scaleY = self.screenHeight / hoveredImgHeight
      love.graphics.draw(overlayImg, 0, 0, 0, scaleX, scaleY)
    end
  end
end

-- Start the transition effect
function ScreenManager:startTransition(newScene)
  if self.isTransitioning then
    return
  end
  self.nextScene = newScene
  self.isTransitioning = true
  self.fadeAlpha = 0 -- Start fade effect
end

-- Draw the transition overlay
function ScreenManager:draw()
  if self.isTransitioning then
    love.graphics.setColor(0, 0, 0, math.min(self.fadeAlpha, 1))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.graphics.setColor(1, 1, 1, 1) -- Reset color
  end
end

return ScreenManager
