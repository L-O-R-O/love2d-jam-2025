-- ===GLOBAL=== --
-- Tabella con le attività schedulate di test, da dismettere.
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

CalendarManager = {}
CalendarManager.__index = CalendarManager

local constants		  = require("constants")

local ActivityOnCalendar = {}                                                     --Istanzio per poter definire funzioni locali
local calendar = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}  -- 1= giorni liberi 0 = giorni occupati
local tmpActivity = {}                                                            --variabile di appoggio per estrarre i giorni  occupati da un attività in  testo
local addedActivities = {}                                                        --tutte le attività aggiunte al calendario fino ad oggi
local month = 1

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


function CalendarManager:new(month)        -- inizializza il calendario al mese indicato
    if (month < 1 or month > 12) then
      return nil
    end

    math.randomseed(os.time())      -- Imposta il seed per rendere i numeri casuali più imprevedibili
    local tmpCalendar = {}          -- temporaneo del calendario

    for i = 1, constants.DAYS_IN_MONTH[month] do
        tmpCalendar[i] = 1
    end

    self.month = month

    calendar=tmpCalendar
    alignCalendar()

    return self
end

function CalendarManager:isFreeDay(month, day)          -- Ritorna True se il giorno è libero
    if constants.DAYS_IN_MONTH[month] < day then
        return false
    else
        if calendar[day]== 1 then
            return true
        else
            return false
        end
    end
end

function CalendarManager:printCalendar() -- Stampa l'attuale calendario --
    io.write("Calendario:  ")
    for giorno = 1, #calendar do
        io.write(calendar[giorno] .. " ")
    end
    print('')
end

function CalendarManager:printActivity(activity) -- Stampa i giorni che un attività occupa --
    io.write("Attivity:  ")
    for day = 1, #activity do
        io.write(activity[day] .. " ")
    end
    print('')
end

function CalendarManager:addNewActivity(activity, activityIndex, nFreeDays)   --cerca e aggiunge una nuova attività al calendario conservando almeno: nFreeDays --
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

function CalendarManager:addActivity(activity, nFreeDays) -- aggiunge una specifica attività al calendario a patto che questa abbia almeno nFreeDays --
    nFreeDays = nFreeDays or 1
    local tmpCalendar = {}

    for i = 1, #calendar do
        tmpCalendar[i] = calendar[i] * activity.calendar[i]
    end

    if minFreeDays(tmpCalendar, nFreeDays) then
        calendar = tmpCalendar
        --print("aggiunta attività al calendario")
    end
end

-- creazione immediata dell'istanza globale
CalendarManager = CalendarManager:new(1)

return CalendarManager
