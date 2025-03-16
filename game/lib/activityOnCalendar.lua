-- ===GLOBAL=== --
-- Tabella con le attività schedulate
activitySchedule = {
    soccer =        {0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, -- Solo il primo giorno occupato
    basket =        {1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, -- Secondo giorno occupato
    golf =          {1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
    PartyHard =     {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1}, -- Solo il 27° giorno
    swimming =      {1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, -- Solo il 4° giorno
    chess =         {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1}, -- Solo il 21° giorno

-- Attività che si ripetono regolarmente
    cooking =       {1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1},
    rock_climbing = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1},
    gaming_night =  {1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1},
    gym =           {1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0},
    jogging =       {0,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1},
    go_kart =       {0,0,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1}
}

-- Tabella indicizzata per accedere con numeri
activityIndex = {
    "soccer", "basket", "golf", "PartyHard", "swimming", "chess",
    "cooking", "rock_climbing", "gaming_night", "gym", "jogging",
    "go_kart"
}

daysInMonth = {               --numero di giorni per ogni mese
    [1] = 31,  -- January
    [2] = 28,  -- February
    [3] = 31,  -- March
    [4] = 30,  -- April
    [5] = 31,  -- May
    [6] = 30,  -- June
    [7] = 31,  -- July
    [8] = 31,  -- August
    [9] = 30,  -- September
    [10] = 31, -- October
    [11] = 30, -- November
    [12] = 31  -- December
}

local ActivityOnCalendar = {}       --Istanzio per poter definire funzioni locali
local calendar = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1} -- 1= giorni liberi 0 = giorni occupati
local tmpActivity = {}              --variabile di appoggio per estrarre i giorni  occupati da un attività in  testo
local addedActivities = {}          --tutte le attività aggiunte al calendario fino ad oggi

-- Optional: Also keep month names as keys
local monthNames = {
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
}
local weekDays = {
    [1] = "Monday", [2] = "Tuesday", [3] = "Wednesday",
    [4] = "Thursday", [5] = "Friday", [6] = "Saturday", [7] = "Sunday"
}
local monthWeekDays = {
    [1] = "Monday", [2] = "Tuesday", [3] = "Wednesday",
    [4] = "Thursday", [5] = "Friday", [6] = "Saturday", [7] = "Sunday"
}

local function updateDayWeekOffset(month)   -- imposta un offset in base al mese per identificare che giorno  è il primo del mese
    local totalDays = 0

    -- Calcola i giorni trascorsi fino al mese precedente
    for i = 1, month - 1 do
        totalDays = totalDays + daysInMonth[i]
    end

    -- Calcola il giorno della settimana (1 = Monday, 7 = Sunday)
    local offset = ((totalDays) % 7) + 1

    -- Ruota la settimana di partenza
    local updatedWeekDays = {}
    local e = offset
    for i = 1, 7 do
        updatedWeekDays[i] = weekDays[e]
        if e==  7 then
            e = 1
        else
            e = e +1
        end
    end
    monthWeekDays = updatedWeekDays
end

local function alignCalendar()      -- aggiorna il calendario con tutte le attività caricate fino ad oggi --
    for i = 1, #addedActivities do
        ActivityOnCalendar.addActivity(activitySchedule[addedActivities[i]])
    end
    return true
end

local function minFreeDays(calendar, nFreeDays)     -- controlla se il calendario passato ha almeno nFreeDays --
    local FreeCalendarDays = 0

    for i = 1, #calendar do
        FreeCalendarDays = FreeCalendarDays + calendar[i]
    end
    if FreeCalendarDays >= nFreeDays then
        return true
    else
        return false
    end
end

local function checkRecurrentDaysOccupied(activity, month, targetDay) -- controlla se un giorno della settimana è sempre occupato da un attività

    local r= ''
    local daysSelected = {}
    local totalDays = daysInMonth[month]
    if totalDays == nil then
        print("Invalid month.")
        return
    end

    -- Assumption: day 1 of the month is Monday (can be customized)
    local allOccupied = true
    local weekDay

    for day = 1, totalDays do
        weekDay = ((day - 1) % 7) + 1
        if weekDay == targetDay then
            if activity[day] == 1 then
                allOccupied = false
            else
                table.insert(daysSelected, day)
            end
        end
    end

    if allOccupied then
        --r =  "Every " .. weekDays[targetDay]
        for e = 1, #daysSelected do
            tmpActivity[daysSelected[e]] = 1
        end
        return true
    else
        tmpActivity = activity
        return false
    end
end

function ActivityOnCalendar.initCalendar(month)     -- inizializza il calendario al mese indicato --
    math.randomseed(os.time())          -- Imposta il seed per rendere i numeri casuali più imprevedibili
    local tmpCalendar = {}              -- temporaneo del calendario

    for i = 1, daysInMonth[month] do
        tmpCalendar[i] = 1
    end

    calendar=tmpCalendar

    alignCalendar()
end

function ActivityOnCalendar.isFreeDay(month, day)          -- Ritorna True se il giorno è libero
    if daysInMonth[month] < day then
        return false
    else
        if calendar[day]== 1 then
            return true
        else
            return false
        end
    end
end

function ActivityOnCalendar.printCalendar() -- Stampa l'attuale calendario --
    io.write("Calendario:  ")
    for giorno = 1, #calendar do
        io.write(calendar[giorno] .. " ")
    end
    print('')
end

function ActivityOnCalendar.printActivity(activity) -- Stampa i giorni che un attività occupa --
    io.write("Attivity:  ")
    for day = 1, #activity do
        io.write(activity[day] .. " ")
    end
    print('')
end

function ActivityOnCalendar.addNewActivity(activity, activityIndex, nFreeDays)   --cerca e aggiunge una nuova attività al calendario conservando almeno: nFreeDays --
    local tmpCalendar = {}
    local added = false
    local selectedActivity = {}

    local index = math.random(1, #activityIndex)  -- Numero tra 10 e 50

    repeat
        selectedActivity = activity[activityIndex[index]]
        for i = 1, #calendar do
            tmpCalendar[i] = calendar[i] * selectedActivity[i]
        end

        if minFreeDays(tmpCalendar, nFreeDays) then
            calendar = tmpCalendar
            added = true
            --print('aggiunto: ' .. activityIndex[index])
            table.insert(addedActivities, activityIndex[index])
        else
            if index==#activityIndex then
                index = 0
            end
            index = index + 1
        end
    until added
end

function ActivityOnCalendar.addActivity(activity, nFreeDays) -- aggiunge una specifica attività al calendario a patto che questa abbia almeno nFreeDays --
    nFreeDays = nFreeDays or 1
    local tmpCalendar = {}

    for i = 1, #calendar do
        tmpCalendar[i] = calendar[i] * activity[i]
    end

    if minFreeDays(tmpCalendar, nFreeDays) then
        calendar = tmpCalendar
        --print("aggiunta attività al calendario")
    end
end

function ActivityOnCalendar.checkAllDaysOccupied(activity, month)   -- Ritorna una stringa con i giorni occupati --
    local r, s, z
    tmpActivity = activity

    updateDayWeekOffset(month)
    -- Check for every day of the week
    for i = 1,7 do
        r = checkRecurrentDaysOccupied(activity, month, i)
        --print(r)
        if r then
            --print(monthWeekDays[i])
            if s == nil then
                s = 'Every ' .. monthWeekDays[i]
            else
                s = s .. ' and ' .. monthWeekDays[i]
            end
        end
    end

    r = false

    if s == nil then

    else
        for i= 1, #activity do
            --print(tmpActivity[i])
        end
    end

    if  s == nil then
        for d = daysInMonth[month], 1, -1 do
            if tmpActivity[d] == 0 then
                if  z == nil then
                    z = d .. ' of the month is taken'
                else
                    z = d .. ', ' .. z
                end
            end
        end
    else
        for d = 1, daysInMonth[month] do
            if tmpActivity[d] == 0 then
                if  z == nil then
                    z = 'plus ' .. d
                else
                    z = d .. ', ' .. z
                end
            end
        end
    end

    if s ==nil then
        if z == nil then
        else
            s = z
        end
    else
        if z == nil then
        else
            s = s .. ' ' .. z
        end
    end


    return s
end



return ActivityOnCalendar
