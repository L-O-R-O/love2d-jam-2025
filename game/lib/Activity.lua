Activity = Class{}

--[[
TO REVIEW:
-- la funzione Offset cancella il calendar indicato mantenendo solo i giorni ricorrenti, se  ve ne sono.
]]

function Activity:init(name, description, calendar, weekly, dayoftheweek)
  self.name         = name
  self.description  = description
  self.calendar     = calendar
  self.weekly       = weekly

  if weekly then
    self.dayoftheweek = dayoftheweek
    buildCalendar()
  else
    self.dayoftheweek = nil
  end
end

function Activity:buildCalendar()

end

function Activity:offset(month)
  local totalDays

  for i = 1, month - 1 do
      totalDays = totalDays + daysInMonth[i]
  end

  local  weekDay = ((totalDays - 1) % 7) + 1

  if self.weekly and self.dayoftheweek then
    -- Pulisco il calendario del mese (31 giorni)
    self.calendar = {}

    for day = 1, 31 do
        -- Calcola il giorno della settimana corrente per questo giorno
        local currentWeekDay = ((weekDay + day - 2) % 7) + 1

        -- Verifica se currentWeekDay è presente in self.dayoftheweek
        local isOccupied = false
        for _, dow in ipairs(self.dayoftheweek) do
            if currentWeekDay == dow then
                isOccupied = true
                break
            end
        end

        -- Se il giorno corrisponde ad uno dei giorni settimanali occupati, metti 0 (occupato), altrimenti 1 (libero)
        if isOccupied then
            self.calendar[day] = 0
        else
            self.calendar[day] = 1
        end
    end
end


end

function Activity:cleanCalendar()
  local calendar = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
  self.calendar = calsendar
end
