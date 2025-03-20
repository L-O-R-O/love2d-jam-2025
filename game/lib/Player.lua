Player = {}
Player.__index = Player

constants = require("constants")
Activity = require("Activity")

function Player:new(name, description, hobby, sport, playable, inGuild)
    -- Controlla se il calendario esiste, altrimenti imposta una tabella vuota
    local hobbyCalendar = constants.repeatedActivity[hobby] or {}
    local sportCalendar = constants.scheduledActivity[sport] or {}

    local obj = {
        name = name,
        description = description,
        strikes = 0,
        hobby = Activity:new(hobby, "", hobbyCalendar), -- Crea attività hobby
        sport = Activity:new(sport, "", sportCalendar, {2}), -- Crea attività sportiva (Martedì)
        playable = playable,
        inGuild = (playable == 1) and inGuild or 0 -- Se non è giocabile, non può essere in una gilda
    }

    setmetatable(obj, Player)
    return obj
end

function Player:getScheduleNames()
    return self.hobby:getName(), self.sport:getName()
end

function Player:getSchedules()
    return self.hobby:getCalendar(), self.sport:getCalendar()
end

function Player:checkAvailability(proposedDate)
    local hobby, sport = self:getSchedules()
    return (hobby[proposedDate] == 0) and (sport[proposedDate] == 0)
end

return Player
