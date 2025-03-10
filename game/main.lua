https = nil
local overlayStats = require("lib.overlayStats")
local runtimeLoader = require("runtime.loader")

function love.load()
  https = runtimeLoader.loadHTTPS()
  overlayStats.load() -- Should always be called last
end

function love.draw()
  overlayStats.draw() -- Should always be called last
end

function love.update(dt)
  overlayStats.update(dt) -- Should always be called last
end

function love.keypressed(key)
  if key == "escape" and love.system.getOS() ~= "Web" then
    love.event.quit()
  else
    overlayStats.handleKeyboard(key) -- Should always be called last
  end
end
