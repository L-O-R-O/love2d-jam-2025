Activity = {}
Activity.__index = Activity

local constants		  = require("constants")

local weekDays = {
  [1] = "Monday", [2] = "Tuesday", [3] = "Wednesday",
  [4] = "Thursday", [5] = "Friday", [6] = "Saturday", [7] = "Sunday"
}
local monthWeekDays = {
  [1] = "Monday", [2] = "Tuesday", [3] = "Wednesday",
  [4] = "Thursday", [5] = "Friday", [6] = "Saturday", [7] = "Sunday"
}

local tmpCalendar   = {}


local function checkRecurrentDaysOccupied(obj, month, targetDay) -- controlla se un giorno della settimana è sempre occupato da un attività

  local r= ''
  local daysSelected = {}
  local totalDays = constants.DAYS_IN_MONTH[month]
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
          if obj.calendar[day] == 1 then
              allOccupied = false
          else
              table.insert(daysSelected, day)
          end
      end
  end

  if allOccupied then
      --r =  "Every " .. weekDays[targetDay]
      for e = 1, #daysSelected do
          tmpCalendar[daysSelected[e]] = 1
      end
      return true
  else
      tmpCalendar = obj.calendar
      return false
  end
end

local function updateDayWeekOffset(month)   -- imposta un offset in base al mese per identificare che giorno  è il primo del mese
  if  month ==1 then
    return
  end

  local totalDays = 0

  -- Calcola i giorni trascorsi fino al mese precedente
  for i = 1, month - 1 do
      totalDays = totalDays + constants.DAYS_IN_MONTH[i]
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

local function checkAllDaysOccupied(obj, month)   -- Ritorna una stringa con i giorni occupati --
  local r, s, z
  tmpCalendar = obj.calendar

  updateDayWeekOffset(month)
  -- Check for every day of the week
  for i = 1,7 do
      r = checkRecurrentDaysOccupied(obj, month, i)
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
      for i= 1, #obj.calendar do
          --print(tmpActivity[i])
      end
  end

  if  s == nil then
      for d = constants.DAYS_IN_MONTH[month], 1, -1 do
          if tmpCalendar[d] == 0 then
              if  z == nil then
                  z = d .. ' of the month is taken'
              else
                  z = d .. ', ' .. z
              end
          end
      end
  else
      for d = 1, constants.DAYS_IN_MONTH[month] do
          if tmpCalendar[d] == 0 then
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

local function buildCalendar(obj) -- nel caso in cui dayoftheweek sia popolato con uno o più giorni della settimana, ricostruisco il calendario in modo che si ripetano
  local tmpcalendar = obj.calendar

  -- Itera su tutti i giorni del mese
  for i = 1, #tmpcalendar do
    -- Calcola il giorno della settimana (1 = lunedì, ..., 7 = domenica)
    local weekday = ((i - 1) % 7) + 1

    -- Controlla se il giorno della settimana è tra quelli indicati
    for _, day in ipairs(obj.dayOfTheWeek) do
      if weekday == day then
        tmpcalendar[i] = 0  -- Imposta a 0 se il giorno corrisponde
      end
    end
  end

  return tmpcalendar  -- Aggiorna il calendario
end

local function cleanCalendar(obj) -- Imposta il calendario a 0
  local tmpCalendar = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  obj.calendar = tmpCalendar
end



function Activity:new(name, description, calendar, dayOfTheWeek)
  local obj = {
    name = name,
    description = description,
    calendar = calendar,
    dayOfTheWeek = dayOfTheWeek,
    strSchedule = ''
  }

  if #calendar == 0 then
    cleanCalendar(obj)
  end

  if dayOfTheWeek == nil or #dayOfTheWeek == 0 then
    obj.dayOfTheWeek = nil
  elseif #dayOfTheWeek >= 1 and   #dayOfTheWeek < 7 then
    obj.calendar = buildCalendar(obj)
  else
    obj.dayOfTheWeek = nil
  end

  obj.strSchedule = checkAllDaysOccupied(obj, 1)

  setmetatable(obj, Activity)
  return obj
end

function Activity:addDaysCalendar(calendar) --aggiungo i giorni occupati al calendario esistente
  if (not calendar or #calendar == 0 or #calendar < 31) then
    return  -- Se non ci sono giorni specificati, esce dalla funzione
  end

  local tmpcalendar = {}

  for i=1, 31 do
    tmpcalendar[i] = self.calendar[i] * calendar[i]
  end

  self.calendar = tmpcalendar  -- Aggiorna il calendario
end

function Activity:setMonth(month) --ricalcola il calendario per il mese passato, in modo da  mantenere la candenza settimanale richiesta nel  costruttore

  if not self.dayOfTheWeek or #self.dayOfTheWeek == 0 then
    return  -- Se non ci sono giorni specificati, esce dalla funzione
  end

  local totalDays = 0

  for i = 1, month - 1 do
      totalDays = totalDays + constants.DAYS_IN_MONTH[i]
  end

  local  weekDay = ((totalDays - 1) % 7) + 1

  local tmpCalendar = {}

  for day = 1, 31 do
      -- Calcola il giorno della settimana corrente per questo giorno
      local currentWeekDay = ((weekDay + day - 1) % 7) + 1

      -- Verifica se currentWeekDay è presente in self.dayoftheweek
      local isOccupied = false
      for _, dow in ipairs(self.dayOfTheWeek) do
          if currentWeekDay == dow then
              isOccupied = true
              break
          end
      end

      -- Se il giorno corrisponde ad uno dei giorni settimanali occupati, metti 0 (occupato), altrimenti 1 (libero)
      if isOccupied then
        tmpCalendar[day] = 0
      else
        tmpCalendar[day] = 1
      end
  end

  self.calendar = tmpCalendar

  self.strSchedule = checkAllDaysOccupied(self, month)
end

---- GET METHODS ----
function Activity:getName()
  return self.name
end

function Activity:getDescription()
  return self.description
end

function Activity:getCalendar()
  return self.calendar
end

function Activity:getDayOfTheWeek()
  return self.dayOfTheWeek
end

function Activity:getStrSchedule()
  return self.strSchedule
end

return Activity
