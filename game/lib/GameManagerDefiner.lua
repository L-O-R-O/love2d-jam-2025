GameManagerDefiner = {}
GameManagerDefiner.__index = GameManagerDefiner

CalendarManager = require("lib.CalendarManager")
require("lib.Player")
constants = require("constants")

local function getMonthFromOS()
  local monthString = os.date("%m")
  local monthNumber = tonumber(monthString)
  return monthNumber
end

playablePlyer =  {}
playableActivities =  {}


function GameManagerDefiner:new(strikes)
  local obj = {
    strikes = strikes,
    guild = {},
    actualCycle     = 1, --0 se non in partita, poi da 1 a 10
    prob            = 0, --OPT
    suddenOn        = 0, --variabile per capire se mostrare o meno la pagina degli orari
    gameOver        = 0,
    month           = getMonthFromOS(),
    consecutiveWins = 0,
    outcomeState    = 0,
  }
  setmetatable(obj, GameManagerDefiner)
  return obj
end

function GameManagerDefiner:fillPlaytableEntity()  -- Riempi la tabella playable Player con i dati dei primi N dove N è il numero di elementi della suddeta tabella con primi dati delle costanti student
  for  i = 1, constants.GAME_MANAGER_MAX_PLAYABLE do
    playableActivities[i] = Activity:new(constants.ACTIVITIES[i].name, constants.ACTIVITIES[i].description,{},{})
    playablePlyer[i] = Player:new(constants.STUDENTS[i].name, constants.STUDENTS[i].nickname, 'a1',{},true,false)
  end
end

function GameManagerDefiner:generateFittableActivities(endIndex)  -- Assegna alle attività dei player valori randomici in modo che torni sempre un valore
  local randActivity = playableActivities[endIndex]
  local trueIndex = endIndex
  local firstVal= math.random(1,7)
  local secondVal
  repeat
    secondVal = math.random(1,7)
  until  secondVal ~= firstVal

  playableActivities[endIndex] = Activity:new(randActivity:getName(),randActivity:getDescription(),{},{firstVal,secondVal})
  CalendarManager:addActivity(playableActivities[endIndex])
  playablePlyer[trueIndex]:setActivity(playableActivities[endIndex])

  for i = 1,(constants.GAME_MANAGER_MAX_PLAYABLE-1) do
    trueIndex = i+endIndex
    if(trueIndex>constants.GAME_MANAGER_MAX_PLAYABLE)then
      trueIndex = trueIndex-constants.GAME_MANAGER_MAX_PLAYABLE
    end

    local newActivity
    repeat
      local tmpCalendar={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
      for j=0,i+2 do
        local r = math.random(1,31)
        tmpCalendar[r] = 0
      end

      playableActivities[trueIndex] =Activity:new(playableActivities[trueIndex]:getName(),playableActivities[trueIndex]:getDescription(),tmpCalendar,{})
    until CalendarManager:addActivity(playableActivities[trueIndex],constants.GAME_MANAGER_MAX_PLAYABLE-i)
    playablePlyer[trueIndex]:setActivity(playableActivities[trueIndex])
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
              self.outcomeState = constants.OUTCOMESTATE[2]
          end
      end
  end
  if self.strikes >= 4 then
    self.gameOver = 1
    self.outcomeState = constants.OUTCOMESTATE[4]
  else
    if self.actualCycle == 10 then
      self.outcomeState = constants.OUTCOMESTATE[3]
    else
      self.month=self.month+1
      self.outcomeState = constants.OUTCOMESTATE[1]
    end
  end
  if(self.consecutiveWins==2)then
      self:addInGuild(self:findSuitablePlayer())
      self.consecutiveWins = 0
  end
end

function GameManagerDefiner:addInGuild(player)
  for i, iPlayer in ipairs(self.guild) do
    if player.name == iPlayer.name then
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
  self.prob = ((guildSize / (strikes + 1)) * (120 / 60) * actualCycle) / 100 --QUESTA RIGA PER TEST
end

function GameManagerDefiner:suddenGenerate() --OPT funzione che ogni tot tempo passato nel ciclo tenta di generare un numero per stabilire se far verificare l'imprevisto
  rand = math.random()

  if rand < self.prob then
    --logica per imprevisto
    self.prob = 0
  else
  end
end

function GameManagerDefiner:findSuitablePlayer()
  local candidatePlayers = {}
  local suitablePlayer

  for i, iPlayer in players do
    if iPlayer.playable == 1 and iPlayer.inGuild == 0 then
      candidatePlayers[#candidatePlayers + 1] = iPlayer
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

math.randomseed(os.time())                    -- Imposta il seed per rendere i numeri casuali più imprevedibili
local index = math.random(1, constants.GAME_MANAGER_MAX_PLAYABLE)  -- Numero tra 1 e 7

GameManager = GameManagerDefiner:new(0)
CalendarManager = CalendarManager:new(GameManager.month)
GameManager:fillPlaytableEntity()
GameManager:generateFittableActivities(index)

function GameManager:resetStrikes()
  self.strikes = 0
end

return GameManager
