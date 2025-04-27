local constants = require("constants")
calendar = {}

-- Cache delle immagini e dei font
local images = {
    background = constants.IMAGES_CALENDAR_BG,
    redCircle = constants.IMAGES_CALENDAR_RED_CIRCLE
}

local fonts = {
    month = love.graphics.newFont("assets/font/NiceChalk.ttf", 70),
    day = love.graphics.newFont("assets/font/NiceChalk.ttf", 45),
    dayName = love.graphics.newFont("assets/font/NiceChalk.ttf", 15)
}

-- Cache dei colori
local colors = {
    black = {0, 0, 0},
    white = {1, 1, 1},
    gray = {0.5, 0.5, 0.5},
    lightGray = {0.9, 0.9, 0.9}
}

-- Cache delle dimensioni
local dimensions = {
    calendarArea = {
        xPerc = 0.27,
        yPerc = 0.05,
        widthPerc = 0.42,
        heightPerc = 0.90
    },
    monthArea = {
        xPerc = 0.4,
        yPerc = 0.17,
        widthPerc = 0.2,
        heightPerc = 0.1
    },
    dayArea = {
        widthPerc = 0.04,
        heightPerc = 0.06
    },
    grid = {
        xOffset = 0.309,
        yOffset = 0.22,
        colWidth = 0.055,
        rowHeight = 0.08,
        diagonalOffset = 0.002
    }
}

-- Cache dello stato
local state = {
    calendarArea = {},
    monthArea = {},
    currentMonth = 0,
    currentMonthLabel = "",
    firstDayOfMonth = 0,
    selectedDay = nil,
    selectedDayLabel = nil,
    redCircle = {
        toDraw = false,
        day = nil
    }
}

-- Lista dei giorni della settimana, abbreviati ed in uppercase
local daysOfWeek = {}
for _, day in ipairs(constants.WEEK_DAYS) do
    table.insert(daysOfWeek, day:sub(1, 3):upper())
end

-- Funzioni di utilità
local function updateMonthData()
    state.currentMonth = GameManager:getMonth()
    state.currentMonthLabel = constants.MONTH_NAMES[state.currentMonth]
    state.firstDayOfMonth = CalendarManager:getFirstDayOfMonth(state.currentMonth)
end

local function getDayOfWeek(day)
    local dayOfWeekIndex = ((state.firstDayOfMonth + day - 2) % #daysOfWeek) + 1
    return daysOfWeek[dayOfWeekIndex]
end

local function calculateDayPosition(day, colIndex, group, yDiagonalOffset)
    local xPerc = dimensions.grid.xOffset + (colIndex * dimensions.grid.colWidth)
    local yPerc = dimensions.grid.yOffset + (group * dimensions.grid.rowHeight) + yDiagonalOffset
    return xPerc, yPerc
end

local function drawDay(day, nameArea, isActive)
    local dayOfWeek = getDayOfWeek(day)
    local textColor = isActive and colors.black or colors.gray

    -- Disegna il nome del giorno
    love.graphics.setFont(fonts.dayName)
    love.graphics.setColor(textColor)
    love.graphics.printf(dayOfWeek, nameArea.x - 0.01, nameArea.y - 20, nameArea.width, "center")

    -- Disegna il numero del giorno
    love.graphics.setFont(fonts.day)
    love.graphics.printf(day, nameArea.x, nameArea.y, nameArea.width, "center")

    -- Ripristina il colore
    love.graphics.setColor(colors.white)
end

local function drawRedCircle(nameArea)
    local image = images.redCircle
    local sx = nameArea.width / image:getWidth() + 0.1
    local sy = nameArea.height / image:getHeight() + 0.1
    local x = nameArea.x + (nameArea.width - image:getWidth() * sx) / 2
    local y = nameArea.y + (nameArea.height - image:getHeight() * sy) / 2 - 10
    love.graphics.setColor(colors.white)
    love.graphics.draw(image, x, y, 0, sx, sy)
end

local function dateClicked(day)
    local dayOfWeekIndex = ((state.firstDayOfMonth + day - 2) % #daysOfWeek) + 1
    state.selectedDay = day
    state.selectedDayLabel = string.sub(constants.WEEK_DAYS[dayOfWeekIndex], 1, 3)
    scenesManager:setScene(constants.SCENES_CONFIRM, false)
end

function calendar.getSelectedDate()
    return {
        day = state.selectedDay,
        month = state.currentMonthLabel,
        dayLabel = state.selectedDayLabel
    }
end

function calendar.load()
    mouse.registerHandler(calendar, constants.SCENES_CALENDAR)

    -- Calcola le aree una sola volta
    state.calendarArea = screenManager:calcAreaSizes(dimensions.calendarArea)
    state.monthArea = screenManager:calcAreaSizes(dimensions.monthArea)

    -- Inizializza i dati del mese
    updateMonthData()
end

function calendar.update(dt)
    -- Aggiorna i dati del mese solo se necessario
    local newMonth = GameManager:getMonth()
    if newMonth ~= state.currentMonth then
        updateMonthData()
    end
end

function calendar.draw()
    -- Disegna lo sfondo
    screenManager:drawSceneBackground(images.background)

    -- Disegna il mese corrente
    love.graphics.setFont(fonts.month)
    love.graphics.setColor(colors.lightGray)
    love.graphics.printf(state.currentMonthLabel, state.monthArea.x, state.monthArea.y, state.monthArea.width, "center")
    love.graphics.setColor(colors.white)

    -- Disegna i giorni del calendario
    local daysInMonth = constants.DAYS_IN_MONTH_ORIGINAL[state.currentMonth]
    local daysInMonthOriginal = constants.DAYS_IN_MONTH_ORIGINAL[state.currentMonth]
    local colIndex = 1
    local yDiagonalOffset = 0
    local previousGroup = 1

    for day = 1, daysInMonthOriginal do
        local group = math.ceil(day / 5)
        if group ~= previousGroup then
            yDiagonalOffset = 0
        end

        local xPerc, yPerc = calculateDayPosition(day, colIndex, group, yDiagonalOffset)
        yDiagonalOffset = yDiagonalOffset - dimensions.grid.diagonalOffset

        local nameArea = screenManager:calcAreaSizes({
            xPerc = xPerc,
            yPerc = yPerc,
            widthPerc = dimensions.dayArea.widthPerc,
            heightPerc = dimensions.dayArea.heightPerc
        })

        local isActive = day <= daysInMonth
        drawDay(day, nameArea, isActive)

        if isActive then
            -- Controllo se disegnare il cerchio rosso
            if state.redCircle.toDraw and state.redCircle.day == day then
                drawRedCircle(nameArea)
            end

            -- Crea l'area cliccabile se non esiste già
            local doesAreaExists = screenManager:checkIfAreaExists(constants.SCENES_CALENDAR, day)
            if not doesAreaExists then
                screenManager:setClickableArea(
                    constants.SCENES_CALENDAR,
                    nameArea,
                    constants.SCENES_CALENDAR,
                    function() dateClicked(day) end,
                    { nameAreaId = day, day = day }
                )
            end
        end

        colIndex = (colIndex % 5) + 1
        previousGroup = group
    end
end

function calendar.keypressed(key)
    if key == constants.KEYS_ESCAPE_MENU then
        scenesManager:setScene(constants.SCENES_DESKTOP)
    elseif key == constants.KEYS_PAUSE_MENU then
        scenesManager:setScene(constants.SCENES_TITLE)
    end
end

function calendar.mousePressed(x, y, button)
    if screenManager:checkIfClickingOutside(x, y, state.calendarArea) then
        scenesManager:setScene(constants.SCENES_DESKTOP)
    end
    screenManager:click(x, y)
end

function calendar.mouseHovered(x, y)
    local clickableArea = screenManager:getClickableArea(x, y)

    if clickableArea then
        mouse.loadCursor(constants.HAND_CURSOR)
        state.redCircle.day = clickableArea.data.day
        state.redCircle.toDraw = true
    else
        state.redCircle.day = nil
        state.redCircle.toDraw = false
        mouse.loadCursor(constants.DEFAULT_CURSOR)
    end
end

return calendar
