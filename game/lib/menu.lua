local constants = require("constants")

Menu = {}
Menu.__index = Menu

function Menu:new(font)
    local instance = {
        items = {},
        selectedIndex = 1,
        subMenus = {},
        parentMenu = nil,
        isOpen = false,
        transitionAlpha = 0, -- Valore iniziale della transizione
        fadingAlpha = 1,     -- Valore iniziale del fade
        isFading = false,
        font = font or love.graphics.getFont() -- Usa il font fornito o quello di default
    }
    setmetatable(instance, Menu)
    return instance
end

function Menu:addItem(name, action, action2, isSlider, spacing)
    table.insert(self.items, {
        name = name,
        action = action or nil,
        action2 = action2 or nil,
        isSlider = isSlider or false,  -- Se è uno slider, lo gestiamo in modo diverso
        spacing = spacing or 30
    })
end

function Menu:addSubMenu(name, subMenu)
    subMenu.parentMenu = self
    self.subMenus[name] = subMenu
end

function Menu:open()
    self.isOpen = true
end

function Menu:close()
    self.isOpen = false
    if self.parentMenu then
        self.parentMenu:open()
    end
end

function Menu:draw()
    if not self.isOpen then return end

    love.graphics.setFont(self.font) -- Imposta il font scelto

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    for i, item in ipairs(self.items) do
      local y = (screenHeight / 2 - (#self.items * self.font:getHeight() / 2) + (i - 1) * self.font:getHeight())
      local x = screenWidth / 2 - self.font:getWidth(item.name) / 2 - 70
      local itemWidth = self.font:getWidth(item.name)
      local itemHeight = self.font:getHeight()

      -- Store item bounds for hit detection
      item.bounds = {
          x = x,
          y = y,
          width = itemWidth,
          height = itemHeight
      }

      -- Effetto glow verde attorno alla voce selezionata
      if i == self.selectedIndex then
          love.graphics.setColor(1, 1, 0, 0.1) -- Verde luminoso più trasparente

          -- Disegna il testo più volte con un piccolo offset per creare l'effetto bagliore
          local offsets = {-2, -1, 1, 2}
          for _, dx in ipairs(offsets) do
              for _, dy in ipairs(offsets) do
                  love.graphics.print(item.name, x + dx, y + dy)
              end
          end
      end

      -- Disegna il testo principale
      love.graphics.setColor(0, 0, 0, 1) -- Nero
      love.graphics.print(item.name, x, y)
      love.graphics.setColor(1, 1, 1, 1) -- Bianco

      -- Se è uno slider, disegna anche una barra
      if item.isSlider then
          local barWidth = 200
          local barHeight = self.font:getHeight() - 10
          local barOffset = 20
          local barX, barY = x + itemWidth + barOffset, y + 5
          local fillWidth = menuManager:getVolume() * barWidth

          -- Store slider bar bounds
          item.sliderBounds = {
              x = barX,
              y = barY,
              width = barWidth,
              height = barHeight
          }

          -- Disegna il contorno della barra
          love.graphics.setColor(0.1, 0.1, 0.1)
          love.graphics.rectangle("line", barX, barY, barWidth, barHeight)

          -- Disegna la parte riempita
          love.graphics.setColor(0.1, 0.1, 0.1)
          love.graphics.rectangle("fill", barX, barY, fillWidth, barHeight)
      end

      -- 🔥 **AGGIORNAMENTO DI Y IN BASE ALLA SPAZIATURA**
      y = y + (item.spacing or 30)
  end

  -- Overlay per la transizione
  if self.transitionAlpha > 0 then
      love.graphics.setColor(0, 0, 0, self.transitionAlpha)
      love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
      love.graphics.setColor(1, 1, 1, 1)  -- Reset del colore
  end
end

function Menu:update(dt)
  -- Gestione della transition
  if self.transitionAlpha > 0 then
      self.transitionAlpha = math.max(0, self.transitionAlpha - dt * 2)  -- Dissolvenza veloce
      return  -- Blocca gli input durante la transizione
  end
  -- Gestione del fading
  if self.isFading then
    if self.fadingAlpha > 0 then
      self.fadingAlpha = self.fadingAlpha - constants.START_GAME_TRANSITION_SPEED * dt
      if self.fadingAlpha < 0 then
        self.fadingAlpha = 0
        self.isFading = false
        scenesManager:setScene(constants.SCENES_DESKTOP,false)
      end
      return  -- Blocca gli input durante la transizione
    end
  end
end

function Menu:keyPressed(key)
    if key == "down" then
        self.selectedIndex = math.min(self.selectedIndex + 1, #self.items)
    elseif key == "up" then
        self.selectedIndex = math.max(self.selectedIndex - 1, 1)
    elseif self.items[self.selectedIndex].isSlider then
        if key == "left" then
            self.items[self.selectedIndex].action()
        elseif key == "right" then
            self.items[self.selectedIndex].action2()
        end
    elseif key == "return" then
        self.items[self.selectedIndex].action()
    elseif key == constants.KEYS_ESCAPE_MENU then
        if (self.parentMenu) then
          self:close()
        end
    end
end


function Menu:openSubMenu(name)
    if self.subMenus[name] then
        self:close()
        self.subMenus[name]:open()
        currentMenu = self.subMenus[name]  -- Aggiorna il menu attivo
        currentMenu:startTransition()  -- Avvia la transizione
    end
end

function Menu:close()
    self.isOpen = false
    if self.parentMenu then
        self.parentMenu:open()
        currentMenu = self.parentMenu  -- Torna al menu precedente
        currentMenu:startTransition()  -- Avvia la transizione
    end
end

function Menu:nextItem()
    print('nextItem, ID:' .. self.selectedIndex .. ' su: ' .. #self.items)
    if self.selectedIndex < #self.items then
        self.selectedIndex = self.selectedIndex + 1
    else
        self.selectedIndex = 1  -- Torna al primo elemento se si è alla fine
    end
end

function Menu:prevItem()
    print('nextItem, ID:' .. self.selectedIndex .. ' su: ' .. #self.items)
    if self.selectedIndex > 1 then
        self.selectedIndex = self.selectedIndex - 1
    else
        self.selectedIndex = #self.items  -- Torna all'ultimo elemento se si è all'inizio
    end
end

function Menu:startTransition()
    self.transitionAlpha = 1  -- Opacità piena (nero)
end
function Menu:startFadingTransition()
  -- self.fadingAlpha
  self.isFading = true
end

function Menu:mousePressed(x, y)
    if not self.isOpen then return end

    for i, item in ipairs(self.items) do
        if item.isSlider and item.sliderBounds then
            -- Check if clicked on slider bar
            if x >= item.sliderBounds.x and
               x <= item.sliderBounds.x + item.sliderBounds.width and
               y >= item.sliderBounds.y and
               y <= item.sliderBounds.y + item.sliderBounds.height then

                self.selectedIndex = i
                -- Calculate relative position in slider (0 to 1)
                local relativePos = (x - item.sliderBounds.x) / item.sliderBounds.width

                -- Split bar into two halves
                if relativePos <= 0.5 then
                    item.action()  -- Decrease (left half)
                else
                    item.action2() -- Increase (right half)
                end
                return
            end
        elseif item.bounds and
               x >= item.bounds.x and
               x <= item.bounds.x + item.bounds.width and
               y >= item.bounds.y and
               y <= item.bounds.y + item.bounds.height then

            self.selectedIndex = i
            if item.action then
                item.action()
            end
            return
        end
    end
end

function Menu:mouseHovered(x, y)
    if not self.isOpen then return end

    -- Check if mouse is over any menu item
    for i, item in ipairs(self.items) do
        if item.bounds and
           x >= item.bounds.x and
           x <= item.bounds.x + item.bounds.width and
           y >= item.bounds.y and
           y <= item.bounds.y + item.bounds.height then
            self.selectedIndex = i
            break
        end
    end
end

return Menu
