-- Libreria per gestire eventi del mouse
local Mouse = {}
Mouse.handlers = {}
Mouse.debounceTime = 0.01 -- 200 milliseconds debounce time
Mouse.lastMousePressed = 0
Mouse.lastMouseHovered = 0
-- Cursori
Mouse.defaultCursorImage = nil
Mouse.cursorHandImage = nil
Mouse.cursorHandClickedImage = nil
Mouse.defaultCursorKey = "default"
Mouse.cursorHandKey = "hand"
Mouse.cursorHandClickedKey = "handClicked"

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

function Mouse.setDefaultCursorsKeys(keys)
  Mouse.defaultCursorKey = keys.default or Mouse.defaultCursorKey
  Mouse.cursorHandKey = keys.hand or Mouse.cursorHandKey
  Mouse.cursorHandClickedKey = keys.handClicked or Mouse.cursorHandClickedKey
end

--- Registra un gestore di eventi del mouse per uno stato specifico
-- @param handler (function) La funzione da chiamare quando viene rilevato un evento del mouse
-- @param state (string) Lo stato associato al gestore
function Mouse.registerHandler(handler, state)
  Mouse.handlers[state] = handler
end

--- Gestisce gli eventi di clic del mouse
-- @param x (number) La coordinata x del click del mouse
-- @param y (number) La coordinata y del click del mouse
-- @param button (number) Il pulsante del mouse che è stato premuto
Mouse.mousePressed = debounciPuzza(function(x, y, button)
  local currentState = scenesManager:getScene()
  local handler = Mouse.handlers[currentState]
  if handler and handler.mousePressed then
    handler.mousePressed(x, y, button)
  end
end, Mouse.debounceTime)

--- Gestisce gli eventi di passaggio del mouse
-- @param x (number) La coordinata x della posizione del mouse
-- @param y (number) La coordinata y della posizione del mouse
Mouse.mouseHovered = debounciPuzza(function(x, y)
  local currentState = scenesManager:getScene()
  local handler = Mouse.handlers[currentState]
  if handler and handler.mouseHovered then
    handler.mouseHovered(x, y)
  end
end, Mouse.debounceTime)

--- Carica e imposta un cursore personalizzato
function Mouse.loadCursor(cursor)
  cursor = cursor or mouse.defaultCursorImage
  if (cursor == nil) then
    return
  end
  if (cursor == Mouse.defaultCursorKey) then
    Mouse.cursor = love.mouse.newCursor(Mouse.defaultCursorImage, 0, 0)
  elseif (cursor == Mouse.cursorHandKey) then
    Mouse.cursor = love.mouse.newCursor(Mouse.cursorHandImage, 0, 0)
  elseif (cursor == Mouse.cursorHandClickedKey) then
    Mouse.cursor = love.mouse.newCursor(Mouse.cursorHandClickedImage, 0, 0)
  end
  love.mouse.setCursor(Mouse.cursor)
end

return Mouse
