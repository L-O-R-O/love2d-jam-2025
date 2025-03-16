local constants = require("constants")

ScreenManager = {}
ScreenManager.__index = ScreenManager

function ScreenManager:new()
     local properties = {
        screenWidth = love.graphics.getWidth(),
        screenHeight = love.graphics.getHeight(),
        resizeAllAreas = false,
        areas = {}
    }
    setmetatable(properties, ScreenManager)
    return properties
end

function ScreenManager:setResolution(w,h)
	self.screenWidth = w
	self.screenHeight = h
  self.resizeAllAreas = true
	love.window.setMode(w, h, {resizable = false})
end

function ScreenManager:setClickableArea(scene,area)
    -- Calculate the click area for the computer rectangle
    area.x      = self.screenWidth  * area.xPerc
    area.y      = self.screenHeight * area.yPerc
    area.width  = self.screenWidth  * area.widthPerc
    area.height = self.screenHeight * area.heightPerc

    if self.areas[scene] == nil then
        self.areas[scene] = {}
    end

    table.insert(self.areas[scene], area)

    return area
end

function ScreenManager:checkIfIsClickable(x,y)
    for scene, areaList in pairs(self.areas) do
        for _, area in ipairs(areaList) do
            if x >= area.x and x <= area.x + area.width and y >= area.y and y <= area.y + area.height then
                return area.name
            end
        end
    end
    return nil
end

return ScreenManager
