Player = {}
Player.__index = Player

Activity = require("lib.Activity")

function Player:new(name, description, activityName, activity, playable, inGuild, favouriteClass)
    -- Controlla se il calendario esiste, altrimenti imposta una tabella vuota

    local obj = {
        name = name,
        description = description,
        strikes = 0,
        activityName = activityName,
        activity = activity,
        playable = playable or false,
        inGuild = (playable == 1) and inGuild or 0, -- Se non è giocabile, non può essere in una gilda
        favouriteClass = favouriteClass or ''
    }

    setmetatable(obj, Player)
    return obj
end

---- SET METHODS ----
function Player:setActivity(par_activity)
  self.activity = par_activity
end

function Player:setInGuild()
  if self.playable == 1 then
    self.inGuild = 1
  end
end

function Player:setOutGuild()
  self.inGuild = 0
end


---- GET METHODS ----
function Player:getActivityName()
  return self.activityName
end

function Player:getPlayable()
  return self.playable
end

function Player:getInGuild()
  return self.inGuild
end

function Player:getFavouriteClass()
  return self.favouriteClass
end

function Player:getName()
  return self.name
end

function Player:getDescription()
  return self.description
end

function Player:getActivity()
  return self.activity
end

return Player
