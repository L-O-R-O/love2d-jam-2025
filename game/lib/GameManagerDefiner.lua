GameManagerDefiner = {}
GameManagerDefiner.__index = GameManagerDefiner

require("lib.Player")
constants = require("constants")

function GameManagerDefiner:new(strikes)
    local obj = {
        strikes = strikes,
        guild = {},
        actualCycle = 10, --0 se non in partita, poi da 1 a 10
        prob = 0, --OPT
        suddenOn = 0, --variabile per capire se mostrare o meno la pagina degli orari
        gameOver = 0,
        month = 1,
        consecutiveWins=0,
        activities={
          { name = "Synchronized Swimming Practice", description = "Even in a bathtub, coordination is key!", associatedPlayer="a"},
          { name = "Marathon Movie Night", description = "Watch an entire trilogy in one sitting!",associatedPlayer="b"},
          { name = "Parkour Training", description = "Climb walls, jump over obstacles, be a ninja!",associatedPlayer="c"},
          { name = "Balloon Animal Sculpting", description = "Master the art of making inflatable pets!",associatedPlayer="d"},
          { name = "Ultimate Frisbee Showdown", description = "Throw, run, and jump like a pro!",associatedPlayer="e"},
          { name = "Glow-in-the-Dark Bowling", description = "Turn off the lights and let the fun begin!",associatedPlayer="f"},
          { name = "Water Balloon Dodgeball", description = "Dodge, throw, and get soaked!", associatedPlayer="g"},
        }
    }
    setmetatable(obj, GameManagerDefiner)
    return obj
end

function GameManagerDefiner:getGuild()
    return self.guild
end

function GameManagerDefiner:addInGuild(player)
    for i, iPlayer in ipairs(self.guild) do
        if(player.name==iPlayer.name)then
            return 0
        end
    end
    self.guild[#self.guild + 1] = player
end

function GameManagerDefiner:removeFromGuild(player)
    for i, iPlayer in ipairs(self.guild) do
        if player.name == iPlayer.name then
            table.remove(self.guild, i) -- Rimuove il player correttamente
            return 0
        end
    end
    return 0
end

function GameManagerDefiner:updateProb() --OPT
    local strikes = self.strikes
    local guildSize = #self.guild
    local actualCycle = self.actualCycle

    --self.prob = ((guildSize/(strikes+1))*(dt/60)*actualCycle)/100 Qua intendo dt come secondi passati
    self.prob = ((guildSize/(strikes+1))*(120/60)*actualCycle)/100 --QUESTA RIGA PER TEST
end

function GameManagerDefiner:suddenGenerate() --OPT funzione che ogni tot tempo passato nel ciclo tenta di generare un numero per stabilire se far verificare l'imprevisto
    rand=math.random()

    if rand  < self.prob then
        --logica per imprevisto
        self.prob=0
    else
    end
end

function GameManagerDefiner:findSuitablePlayer()
    local candidatePlayers={}
    local suitablePlayer

    for i,iPlayer in players do
        if(iPlayer.playable==1 and iPlayer.inGuild==0)then
            candidatePlayers[#candidatePlayers+1] = iPlayer
        end
    end

    return suitablePlayer
end

function GameManagerDefiner:tryDate(proposedDate)
    for i = #self.guild, 1, -1 do
        local player = self.guild[i]
        if not player:checkAvailability(proposedDate) then
            player.strikes = player.strikes + 1
            if player.strikes >= 2 then
                self:removeFromGuild(player)
                self.strikes = self.strikes + 1
                self.consecutiveWins = self.consecutiveWins+1
            end
        end
    end
    if self.strikes >= 4 then
        self.gameOver = 1
    else
      self.month=self.month+1
    end
    if(self.consecutiveWins==2)then
        self:addInGuild(self:findSuitablePlayer())
        self.consecutiveWins = 0
    end
end

function GameManagerDefiner:generateFittableActivities(endIndex)
  local randActivity = self.activities[endIndex]
  local trueIndex = endIndex+1
  CalendarManager = CalendarManager:new(self.month)
  local firstVal= {math.random(1,31)}
  repeat
    secondVal = math.random(1,31)
  until  secondVal ~= firstVal

  firstActivity = Activity:new(randActivity.name,randActivity.description,{},{firstVal,secondVal})
  CalendarManager:addActivity(firstActivity)

  for i = 0,6 do
    trueIndex = i+endIndex
    if(trueIndex>7)then
      trueIndex = trueIndex-7
    end
    repeat
      local tmpCalendar={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
      for j=0,i+2 do
        local r = math.random(1,31)
        tmpCalendar[r] = 0
      end

      local newActivity=Activity:new(self.activities[trueIndex].name,self.activities[trueIndex].description,tmpCalendar,{})
    until CalendarManager:addActivity(newActivity,7-i)

  end
end

local index = math.random(1, 7)  -- Numero tra 1 e 7

GameManager = GameManagerDefiner:new(0)
GameManager:generateFittableActivities(index)

return GameManager


