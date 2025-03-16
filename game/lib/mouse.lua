local Mouse = {}
Mouse.handlers = {}
Mouse.debounceTime = 0.2 -- 200 milliseconds debounce time
Mouse.lastMousePressed = 0
Mouse.lastMouseHovered = 0

--- Funzione di debounce
-- @param func (function) La funzione da debouncizzare
-- @param delay (number) Il ritardo di debounce in secondi
-- @return (function) La funzione debouncizzata
local function debounciPuzza(func, delay)
  local lastCall = 0
  return function(...)
    local now = love.timer.getTime()
    if now - lastCall >= delay then
      lastCall = now
      func(...)
    end
  end
end

--- Registra un gestore di eventi del mouse per uno stato specifico
-- @param state (string) Lo stato associato al gestore
-- @param handler (function) La funzione da chiamare quando viene rilevato un evento del mouse
function Mouse.registerHandler(handler, state)
  Mouse.handlers[state] = handler
end

--- Gestisce gli eventi di clic del mouse
-- @param x (number) La coordinata x del click del mouse
-- @param y (number) La coordinata y del click del mouse
-- @param button (number) Il pulsante del mouse che è stato premuto
Mouse.mousePressed = debounciPuzza(function(x, y, button)
  local currentState = statesManager:getState()
  local handler = Mouse.handlers[currentState]
  if handler and handler.mousePressed then
    handler.mousePressed(x, y, button)
  end
end, Mouse.debounceTime)

--- Gestisce gli eventi di passaggio del mouse
-- @param x (number) La coordinata x della posizione del mouse
-- @param y (number) La coordinata y della posizione del mouse
Mouse.mouseHovered = debounciPuzza(function(x, y)
  local currentState = statesManager:getState()
  local handler = Mouse.handlers[currentState]
  if handler and handler.mouseHovered then
    handler.mouseHovered(x, y)
  end
end, Mouse.debounceTime)

--- Carica e imposta un cursore personalizzato con ridimensionamento
-- @param imagePath (string) Il percorso dell'immagine del cursore
-- @param width (number) La larghezza desiderata del cursore
-- @param height (number) L'altezza desiderata del cursore
function Mouse.loadCursor(imagePath, width, height)
  local image = love.graphics.newImage(imagePath)
  local canvas = love.graphics.newCanvas(width, height)
  love.graphics.setCanvas(canvas)
  love.graphics.clear()
  love.graphics.draw(image, 0, 0, 0, width / image:getWidth(), height / image:getHeight())
  love.graphics.setCanvas()
  local resizedImageData = canvas:newImageData()
  Mouse.cursor = love.mouse.newCursor(resizedImageData, 0, 0)
  love.mouse.setCursor(Mouse.cursor)
end

return Mouse
