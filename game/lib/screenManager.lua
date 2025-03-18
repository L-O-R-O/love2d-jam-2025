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
      nextScene = nil
    }
    setmetatable(properties, ScreenManager)
    return properties
end

function ScreenManager:setResolution(w, h)
    self.screenWidth = w
    self.screenHeight = h
    self.resizeAllAreas = true
    love.window.setMode(w, h, {resizable = false})
end

function ScreenManager:setClickableArea(scene, area)
    area = self:setDrawableArea(area)

    if self.areas[scene] == nil then
        self.areas[scene] = {}
    end

    table.insert(self.areas[scene], area)
    return area
end

function ScreenManager:setDrawableArea(area)
  area.x = self.screenWidth * area.xPerc
  area.y = self.screenHeight * area.yPerc
  area.width = self.screenWidth * area.widthPerc
  area.height = self.screenHeight * area.heightPerc
  return area
end

function ScreenManager:checkIfIsClickable(x, y)
    for scene, areaList in pairs(self.areas) do
        for _, area in ipairs(areaList) do
            if x >= area.x and x <= area.x + area.width and y >= area.y and y <= area.y + area.height then
                return area.name
            end
        end
    end
    return nil
end

function ScreenManager:setScene(scene)
    if self.isTransitioning then return end

    self.nextScene = scene
    self.isTransitioning = true
    self.fadeAlpha = 0 -- Start fade-in
end

function ScreenManager:update(dt)
    if self.isTransitioning then
        self.fadeAlpha = self.fadeAlpha + self.transitionSpeed * dt
        if self.fadeAlpha >= 1 then
            self.currentScene = self.nextScene
            self.nextScene = nil
            self.fadeAlpha = 1 -- Hold full black briefly before fading out
        elseif self.fadeAlpha >= 2 then
            self.isTransitioning = false
            self.fadeAlpha = 0
        end
    end
end

function ScreenManager:draw()
    if self.isTransitioning then
        love.graphics.setColor(0, 0, 0, math.min(self.fadeAlpha, 1))
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1) -- Reset color
    end
end

-- Start the transition effect
function ScreenManager:startTransition(newScene)
  if self.isTransitioning then return end
  self.nextScene = newScene
  self.isTransitioning = true
  self.fadeAlpha = 0 -- Start fade effect
end

function ScreenManager:drawSceneBackground(img,hoverImages)
  -- Get image dimensions
  local imgWidth, imgHeight = img:getWidth(), img:getHeight()

  -- Calculate scaling factors for full screen
  local scaleX = self.screenWidth / imgWidth
  local scaleY = self.screenHeight / imgHeight

  -- Draw the image with scaling
  love.graphics.draw(img, 0, 0, 0, scaleX, scaleY)
  -- Draw the overlay image on top of the base image
  if isHovered and hoverImages ~= nil and hoveredArea ~= nil  then
    if hoverImages[hoveredArea] ~= nil then
      local overlayImg = hoverImages[hoveredArea]
      love.graphics.draw(overlayImg, 0, 0, 0, scaleX, scaleY)
    end
  end
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

-- Draw the transition overlay
function ScreenManager:draw()
  if self.isTransitioning then
      love.graphics.setColor(0, 0, 0, math.min(self.fadeAlpha, 1))
      love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
      love.graphics.setColor(1, 1, 1, 1) -- Reset color
  end
end

return ScreenManager
