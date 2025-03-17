Activity = {}
Activity.__index = Activity

local constants		  = require("constants")

function Activity:new(name, description, calendar, dayOfTheWeek)
  self.name         = name
  self.description  = description

  if #calendar == 0 then
    Activity:cleanCalendar()
  else
    self.calendar     = calendar
  end

  if #dayOfTheWeek == nil then
    self.dayOfTheWeek = nil
  elseif #dayOfTheWeek >= 1 then
    self.dayOfTheWeek = dayOfTheWeek
    Activity:buildCalendar()
  else
    self.dayOfTheWeek = nil
  end

  return self
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

function Activity:buildCalendar() -- nel caso in cui dayoftheweek sia popolato con uno o più giorni della settimana, ricostruisco il calendario in modo che si ripetano
  if not self.dayOfTheWeek or #self.dayOfTheWeek == 0 then
    return  -- Se non ci sono giorni specificati, esce dalla funzione
  end

  local tmpcalendar = self.calendar

  -- Itera su tutti i giorni del mese
  for i = 1, #tmpcalendar do
    -- Calcola il giorno della settimana (1 = lunedì, ..., 7 = domenica)
    local weekday = ((i - 1) % 7) + 1

    -- Controlla se il giorno della settimana è tra quelli indicati
    for _, day in ipairs(self.dayOfTheWeek) do
      if weekday == day then
        tmpcalendar[i] = 0  -- Imposta a 0 se il giorno corrisponde
      end
    end
  end

  self.calendar = tmpcalendar  -- Aggiorna il calendario

end

function Activity:offset(month) --ricalcola il calendario per il mese passato, in modo da  mantenere la candenza settimanale richiesta nel  costruttore

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

end

function Activity:cleanCalendar() -- Imposta il calendario a 0
  local tmpCalendar = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  self.calendar = tmpCalendar
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

return Activity
