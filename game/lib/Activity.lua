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
  for x = 1, #obj.calendar do
    tmpCalendar[x] = obj.calendar[x]
  end

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
      for d = constants.DAYS_IN_MONTH[month],1,-1  do
          if tmpCalendar[d] == 0 then
              if  z == nil then
                  z = '' .. d
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
        z = 'plus ' .. z
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

---- PRINT METHOD ----
function Activity:printActivity() -- Stampa i giorni che un attività occupa --
  io.write("Attivity:  ")
  for day = 1, #self.calendar do
      io.write(self.calendar[day] .. " ")
  end
  print('')
end

return Activity
