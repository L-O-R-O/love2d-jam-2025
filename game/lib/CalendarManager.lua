CalendarManager = {}
CalendarManager.__index = CalendarManager

local constants		  = require("constants")

local ActivityOnCalendar = {}                                                     -- Istanzio per poter definire funzioni locali
local calendar = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}  -- 1= giorni liberi 0 = giorni occupati
local tmpActivity = {}                                                            -- variabile di appoggio per estrarre i giorni  occupati da un attività in  testo
local addedActivities = {}                                                        -- tutte le attività aggiunte al calendario fino ad oggi
local month = 1
local calendarYear = {}
local tmpYearActivity = {}                                                        -- variabile di appoggio per estrarre i giorni  occupati da un attività in  testo
local iteration = 0

local function tableContains(tbl, value)
  for _, v in pairs(tbl) do
      if v == value then
          return true -- Valore trovato
      end
  end
  return false -- Valore non trovato
end

local function minFreeDays(calendar, nFreeDays)                                   -- controlla se il calendario passato ha almeno nFreeDays --
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

function CalendarManager:resetYearlyCalendar(cal)
  cal = cal or tmpYearActivity

  for i = 1,12 do
    cal[i] = {}
    for e = 1, constants.DAYS_IN_MONTH_ORIGINAL[i] do
      cal[i][e]= 1
    end
  end

  return cal
end

function CalendarManager:printYearlyCalendar()
  for month, days in ipairs(calendarYear) do
    print("Month:", month, "Days:", table.concat(days, ", "))
  end
end

function CalendarManager:alignCalendar()                -- aggiorna il calendario con tutte le attività caricate fino ad oggi --
  if not addedActivities then
    return
  end
  for i = 1, #addedActivities do
      CalendarManager:addActivity(activitySchedule[addedActivities[i]])
  end
  return
end

function CalendarManager:new(month)                     -- inizializza il calendario al mese indicato
  if (month < 1 or month > 12) then
    return nil
  end

  calendarYear = CalendarManager:resetYearlyCalendar(calendarYear)
  tmpYearActivity = CalendarManager:resetYearlyCalendar(tmpYearActivity)

  CalendarManager:printYearlyCalendar()
  local tmpCalendar = {}          -- temporaneo del calendario
  for i = 1, constants.DAYS_IN_MONTH[month] do
      tmpCalendar[i] = 1
  end

  self.month = month

  calendar=tmpCalendar

  if month ~= 1 then
    CalendarManager:alignCalendar()
  end

  return self
end

function CalendarManager:isFreeDay(month, day)          -- Ritorna True se il giorno è libero
  if calendarYear[month][day] == 0 then
    return false
  else
    return true
  end
end

function CalendarManager:printCalendar()                -- Stampa l'attuale calendario --
  io.write("Calendario:  ")
  for giorno = 1, #calendar do
      io.write(calendar[giorno] .. " ")
  end
  print('')
end

function CalendarManager:addNewActivity(activity, activityIndex, nFreeDays)   -- cerca e aggiunge una nuova attività al calendario conservando almeno: nFreeDays --
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

function CalendarManager:addActivityYearly(activity, nFreeDays)
  nFreeDays = nFreeDays or 1
  local actCalendar = activity.calendar
  local actDotw = activity.dayOfTheWeek or {}
  local totalDays = 0
  local x = 0
  local dotw = 0

  for i = 1,12 do
    totalDays = 0
    for y = 1, i - 1 do
      totalDays = totalDays + constants.DAYS_IN_MONTH_ORIGINAL[y]
    end
    dotw = ((totalDays) % 7) + 1

    for e = 1, constants.DAYS_IN_MONTH_ORIGINAL[i] do
      if #actDotw == 0 then
        tmpYearActivity[i][e]= calendarYear[i][e] * actCalendar[e]
      else
        if dotw > 7 then  -- Calcola il giorno della settimana (1 = Monday, 7 = Sunday)
          dotw = 1
        end
        if tableContains(actDotw, dotw) then
          tmpYearActivity[i][e]= 0
        end
        dotw = dotw +1
      end

      x=x+tmpYearActivity[i][e]
    end

    if x<=nFreeDays then
      iteration = iteration+1
      return false
    end
  end

  calendarYear = tmpYearActivity
  return true
end

function CalendarManager:addActivity(activity, nFreeDays) -- aggiunge una specifica attività al calendario a patto che questa abbia almeno nFreeDays --
  nFreeDays = nFreeDays or 1
  local tmpCalendar = {}

  for i = 1, #calendar do
      tmpCalendar[i] = calendar[i] * activity.calendar[i]
  end

  if minFreeDays(tmpCalendar, nFreeDays) then
      calendar = tmpCalendar
      table.insert(addedActivities, activity.calendar)
      return true
  end
  return false
end

function CalendarManager:reset()
  calendar = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  calendarYear = CalendarManager:resetYearlyCalendar(calendarYear)
  tmpYearActivity = CalendarManager:resetYearlyCalendar(tmpYearActivity)
  addedActivities = {}
end

function CalendarManager:getFirstDayOfMonth(month)        -- ritorna il primo giorno della settimana del mese indicato
  if  month == 1 then
    return 1
  end

  local totalDays = 0

  -- Calcola i giorni trascorsi fino al mese precedente
  for i = 1, month - 1 do
      totalDays = totalDays + constants.DAYS_IN_MONTH_ORIGINAL[i]
  end

  -- Calcola il giorno della settimana (1 = Monday, 7 = Sunday)
  local firstDay = ((totalDays) % 7) + 1

  return firstDay
end

return CalendarManager
