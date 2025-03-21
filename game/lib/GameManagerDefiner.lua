GameManagerDefiner = {}
GameManagerDefiner.__index = GameManagerDefiner

CalendarManager     = require("lib.CalendarManager")
require("lib.Player")
constants = require("constants")

local function getMonthFromOS()
  local monthString = os.date("%m")
  local monthNumber = tonumber(monthString)
  return monthNumber
end

playablePlyer =  {
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
  Player:new('', '', '',{},false,false),
}

function GameManagerDefiner:new(strikes)
    local obj = {
        strikes = strikes,
        guild = {},
        actualCycle = 10, --0 se non in partita, poi da 1 a 10
        prob = 0, --OPT
        suddenOn = 0, --variabile per capire se mostrare o meno la pagina degli orari
        gameOver = 0,
        month = getMonthFromOS(),
        consecutiveWins=0,
        activities={
          { name = "Synchronized Swimming Practice", description = "Even in a bathtub, coordination is key!", associatedPlayer="a"},
          { name = "Marathon Movie Night", description = "Watch an entire trilogy in one sitting!",associatedPlayer="b"},
          { name = "Parkour Training", description = "Climb walls, jump over obstacles, be a ninja!",associatedPlayer="c"},
          { name = "Balloon Animal Sculpting", description = "Master the art of making inflatable pets!",associatedPlayer="d"},
          { name = "Ultimate Frisbee Showdown", description = "Throw, run, and jump like a pro!",associatedPlayer="e"},
          { name = "Glow-in-the-Dark Bowling", description = "Turn off the lights and let the fun begin!",associatedPlayer="f"},
          { name = "Water Balloon Dodgeball", description = "Dodge, throw, and get soaked!", associatedPlayer="g"},
          { name = "t1", description = "Throw, run, and jump like a pro!",associatedPlayer="h"},
          { name = "t2", description = "Turn off the lights and let the fun begin!",associatedPlayer="i"},
          { name = "t3", description = "Dodge, throw, and get soaked!", associatedPlayer="i"},
        },
        outcomeState = 0
    }
    setmetatable(obj, GameManagerDefiner)
    return obj
end

function GameManagerDefiner:generatePlayers()  -- Riempi la tabella playable Player con i dati dei primi N dove N è il numero di elementi della suddeta tabella con primi dati delle costanti student
  for  i = 1, #playablePlyer do
    playablePlyer[i] = Player:new(constants.STUDENTS[i].name, constants.STUDENTS[i].nickname, 'a1',{},true,false)
  end
end

function GameManagerDefiner:generateFittableActivities(endIndex)  -- Assegna alle attività dei player valori randomici in modo che torni sempre un valore
  local randActivity = self.activities[endIndex]
  local trueIndex = endIndex
  local firstVal= math.random(1,7)
  local secondVal
  repeat
    secondVal = math.random(1,7)
  until  secondVal ~= firstVal

  firstActivity = Activity:new(randActivity.name,randActivity.description,{},{firstVal,secondVal})
  CalendarManager:addActivity(firstActivity)
  playablePlyer[trueIndex]:setActivity(firstActivity)

  for i = 1,(#self.activities-1) do
    trueIndex = i+endIndex
    if(trueIndex>#self.activities)then
      trueIndex = trueIndex-#self.activities
    end

    local newActivity
    repeat
      local tmpCalendar={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
      for j=0,i+2 do
        local r = math.random(1,31)
        tmpCalendar[r] = 0
      end

      newActivity =Activity:new(self.activities[trueIndex].name,self.activities[trueIndex].description,tmpCalendar,{})
    until CalendarManager:addActivity(newActivity,#self.activities-i)
    playablePlyer[trueIndex]:setActivity(newActivity)
  end
end

function GameManagerDefiner:tryDate(proposedDate)
  for i = #self.guild, 1, -1 do
      local player = self.guild[i]
      if not CalendarManager:isFreeDay(self.month, proposedDate) then
          player.strikes = player.strikes + 1
          if player.strikes >= 2 then
              self.strikes = self.strikes + 1
              self.consecutiveWins = self.consecutiveWins+1
              self.outcomeState = constants.OUTCAMESTATE[2]
          end
      end
  end
  if self.strikes >= 4 then
    self.gameOver = 1
    self.outcomeState = constants.OUTCAMESTATE[4]
  else
    if self.actualCycle == 10 then
      self.outcomeState = constants.OUTCAMESTATE[3]
    else
      self.month=self.month+1
      self.outcomeState = constants.OUTCAMESTATE[1]
    end
  end
  if(self.consecutiveWins==2)then
      self:addInGuild(self:findSuitablePlayer())
      self.consecutiveWins = 0
  end
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

---- GET METHOD ----
function GameManagerDefiner:getMonth()
  return self.month
end

function GameManagerDefiner:getStrikes()
  return self.strikes
end

function GameManagerDefiner:getGuild()
    return self.guild
end

function GameManagerDefiner:getMonth()
  return self.month
end

function GameManagerDefiner:getOutcomeState()
  return self.outcomeState
end

math.randomseed(os.time())      -- Imposta il seed per rendere i numeri casuali più imprevedibili
local index = math.random(1, #playablePlyer)  -- Numero tra 1 e 7

GameManager = GameManagerDefiner:new(0)
CalendarManager = CalendarManager:new(GameManager.month)
GameManager:generatePlayers()
GameManager:generateFittableActivities(index)

return GameManager
