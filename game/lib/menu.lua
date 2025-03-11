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

    local y = 100 -- Posizione iniziale Y
    for i, item in ipairs(self.items) do
        local x = 100

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
        love.graphics.setColor(1, 1, 1, 1) -- Bianco
        love.graphics.print(item.name, x, y)

        -- Se è uno slider, disegna anche una barra
        if item.isSlider then
            local barX, barY = x + 150, y + 5
            local barWidth = 100
            local barHeight = self.font:getHeight() - 10
            local fillWidth = menuManager:getVolume() * barWidth

            -- Disegna il contorno della barra
            love.graphics.setColor(0.1, 0.1, 0.1)
            love.graphics.rectangle("line", barX, barY, barWidth, barHeight)

            -- Disegna la parte riempita
            love.graphics.setColor(1, 1, 1) -- Verde
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
    -- Gestione del fade-out
    if self.transitionAlpha > 0 then
        self.transitionAlpha = math.max(0, self.transitionAlpha - dt * 2)  -- Dissolvenza veloce
        return  -- Blocca gli input durante la transizione
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
    elseif key == "escape" then
        self.close()
    end
end


function Menu:gamepadpressed(joystick, button)
    if button == "dpdown" then
        self.selectedIndex = math.min(self.selectedIndex + 1, #self.items)
    elseif button == "dpup" then
        self.selectedIndex = math.max(self.selectedIndex - 1, 1)
    elseif self.items[self.selectedIndex].isSlider then
        if button == "dpleft" then
            self.items[self.selectedIndex].action()
        elseif button == "dpright" then
            self.items[self.selectedIndex].action2()
        end
    elseif button == "a" then
        self.items[self.selectedIndex].action()
    elseif button == "b" then
        if self == nil then
            os.exit()
        else
            self.close()
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

return Menu
