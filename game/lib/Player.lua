Player = {}
Player.__index = Player
constants=require("constants")
function Player:new(name, description, hobby, sport,inGuild)
    local obj = {
        name = name,
        description = description,
        hobby = hobby,
        sport = sport,
        inGuild=inGuild
    }
    setmetatable(obj, Player)
    return obj
end

function Player:getName()
    return self.name
end

function Player:getScheduleNames()
    return self.hobby,self.sport
end

function Player:getSchedules()
    return constants.repeatedActivity[self.hobby],constants.scheduledActivity[self.sport]
end

function Player:checkAvailability(proposedDate)
    hobby, sport = self:getSchedules()
    return (hobby[proposedDate] == 0) and (sport[proposedDate] == 0)
end
return Player
