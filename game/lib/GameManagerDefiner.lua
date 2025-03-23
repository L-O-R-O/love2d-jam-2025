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

orderedStudents     = {}
allStudents         = {}
allActivities       = {}
playablePlayer      = {}
playableActivities  = {}


function GameManagerDefiner:new()
  local obj = {
    hearts          = constants.MAX_HEARTS,
    guild           = {},
    actualCycle     = 1, --0 se non in partita, poi da 1 a 10
    prob            = 0, --OPT
    suddenOn        = 0, --variabile per capire se mostrare o meno la pagina degli orari
    gameOver        = 0,
    month           = getMonthFromOS(),
    consecutiveWins = 0,
    outcomeState    = 0,
  }
  CalendarManager = CalendarManager:new(getMonthFromOS())

  setmetatable(obj, GameManagerDefiner)
  return obj
end

function GameManagerDefiner:initialize()
  math.randomseed(os.time())                    -- Imposta il seed per rendere i numeri casuali più imprevedibili
  local index = math.random(1, constants.GAME_MANAGER_MAX_PLAYABLE)  -- Numero tra 1 e 7
  CalendarManager:reset()
  -- Setup variabili globali --
  GameManager:fillGlobalTables()
  GameManager:generateFittableActivities(index)
  GameManager:generateOrderedStudents()
  GameManager:generateOrderedActivities()

  -- Preparazione gioco --
  CalendarManager:reset()
  GameManager:addInGuild(index)
  if index >= constants.GAME_MANAGER_MAX_PLAYABLE then
    GameManager:addInGuild(1)
  else
    GameManager:addInGuild(index+1)
  end
end

function GameManagerDefiner:reset()
  self.hearts           = constants.MAX_HEARTS
  self.guild            = {}
  self.actualCycle      = 1 --0 se non in partita, poi da 1 a 10
  self.month            = getMonthFromOS()

  GameManager:initialize()
end

function GameManagerDefiner:generateOrderedStuedent()
  -- Crea una copia della tabella STUDENTS per evitare di modificare l'originale
  orderedStudents = {}
  for _, student in ipairs(constants.STUDENTS) do
      table.insert(orderedStudents, student)
  end

  -- Ordina la copia basandosi sul campo 'name'
  table.sort(orderedStudents, function(a, b)
      return a.name < b.name
  end)
end

function GameManagerDefiner:generateOrderedActivities()
  orderedActivities = {}
    for _, activity in ipairs(constants.ACTIVITIES) do
    table.insert(orderedActivities,activity)
  end
  table.sort(orderedActivities, function(a, b)
    return a.name < b.name
  end)
  for i,iActivity in ipairs(orderedActivities)do
    print(i, iActivity.name)
  end
  print("\n")
end

function GameManagerDefiner:fillGlobalTables()  -- Riempi la tabella playable Player con i dati dei primi N dove N è il numero di elementi della suddeta tabella con primi dati delle costanti student
  for  i = 1, constants.GAME_MANAGER_MAX_PLAYABLE do
    playableActivities[i] = Activity:new(constants.ACTIVITIES[i].name, constants.ACTIVITIES[i].description,{},{})
    playablePlayer[i] = Player:new(constants.STUDENTS[i].name, constants.STUDENTS[i].nickname, playableActivities[i]:getName(),playableActivities[i],true,false)
    allStudents[i] = playablePlayer[i]
    allActivities[i] = playableActivities[i]
  end

  for i = constants.GAME_MANAGER_MAX_PLAYABLE+1, #constants.STUDENTS do
    local r = math.random(1,7)
    allActivities[i] = Activity:new(constants.ACTIVITIES[i].name, constants.ACTIVITIES[i].description,{},{r})
    allStudents[i] = Player:new(constants.STUDENTS[i].name, constants.STUDENTS[i].nickname, constants.ACTIVITIES[i].name,allActivities[i],false,false)
  end
end

function GameManagerDefiner:generateFittableActivities(endIndex)  -- Assegna alle attività dei player valori randomici in modo che torni sempre un valore
  local randActivity = playableActivities[endIndex]
  local trueIndex = endIndex
  local firstDay= math.random(1,7)
  local secondDay, thirdDay
  repeat
    secondDay = math.random(1,7)
  until  secondDay ~= firstDay
  repeat
    thirdDay = math.random(1,7)
  until  secondDay ~= firstDay and thirdDay ~= secondDay

  local tmpActivity = Activity:new(randActivity:getName(),randActivity:getDescription(),{},{firstDay,secondDay, thirdDay})
  playableActivities[endIndex] = tmpActivity
  CalendarManager:addActivity(playableActivities[endIndex])
  playablePlayer[trueIndex]:setActivity(playableActivities[endIndex])
  allActivities[trueIndex] = tmpActivity

  for i = 1,(constants.GAME_MANAGER_MAX_PLAYABLE-1) do
    trueIndex = i+endIndex
    if(trueIndex>constants.GAME_MANAGER_MAX_PLAYABLE)then
      trueIndex = trueIndex-constants.GAME_MANAGER_MAX_PLAYABLE
    end

    local newActivity

    local chance = math.random()
    if(chance<0.60)then
      repeat
        local tmpCalendar={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
        for j=0,i+5 do
          local r = math.random(1,31)
          tmpCalendar[r] = 0
        end

        newActivity = Activity:new(playableActivities[trueIndex]:getName(),playableActivities[trueIndex]:getDescription(),tmpCalendar,{})
        playableActivities[trueIndex] = newActivity
        allActivities[trueIndex] = newActivity
      until CalendarManager:addActivity(newActivity,constants.GAME_MANAGER_MAX_PLAYABLE-i)
    elseif(chance>=0.60 and chance < 0.9)then
        repeat
          local r = math.random(1,7)
          newActivity = Activity:new(playableActivities[trueIndex]:getName(),playableActivities[trueIndex]:getDescription(),{},{r})
          playableActivities[trueIndex] = newActivity
          allActivities[trueIndex] = newActivity
        until CalendarManager:addActivity(newActivity,constants.GAME_MANAGER_MAX_PLAYABLE-i)
    else
      repeat
        local tmpCalendar={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
        for j=0,i+2 do
          local r1 = math.random(1,31)
          tmpCalendar[r1] = 0
        end
        local r2 = math.random(1,7)
        newActivity = Activity:new(playableActivities[trueIndex]:getName(),playableActivities[trueIndex]:getDescription(),tmpCalendar,{r2})
      until CalendarManager:addActivity(newActivity,constants.GAME_MANAGER_MAX_PLAYABLE-i)
      playableActivities[trueIndex] = newActivity
      allActivities[trueIndex] = newActivity
    end
    playablePlayer[trueIndex]:setActivity(playableActivities[trueIndex])
  end
  for i,iPlayer in ipairs(playablePlayer)do
    print(iPlayer:getName())
  end
end

function GameManagerDefiner:tryDate(proposedDate)
  if CalendarManager:isFreeDay(self.month, proposedDate) then
    if self.actualCycle >= 10 then
      self.outcomeState = constants.OUTCOMESTATE[3]   --Game Win
    else
      self.outcomeState = constants.OUTCOMESTATE[1]   --Session Win
    end
  else
    self.hearts = self.hearts
    if self.hearts <= 0 then
      self.outcomeState = constants.OUTCOMESTATE[4]   --Game KO
    else
      self.outcomeState = constants.OUTCOMESTATE[2]   --Session KO
    end
  end

  if self.outcomeState ==  constants.OUTCOMESTATE[1] or self.outcomeState ==  constants.OUTCOMESTATE[2] then
    self.actualCycle = self.actualCycle +1
    if self.month == 12 then
      self.month = 1
    else
      self.month = self.month + 1
    end
  end

  if self.actualCycle % 2 == 0 and self.actualCycle ~= 2 then
    local i = math.floor(self.actualCycle)
    self:addInGuild(i)
  end
end

function GameManagerDefiner:addInGuild(i)
  table.insert(self.guild, #self.guild+1, playablePlayer[i])
  if(i>7)then

  end
  if(playablePlayer[i]:getInGuild()==0)then
    playablePlayer[i]:setInGuild()
    CalendarManager:addActivity(playablePlayer[i]:getActivity())
    return true
  end
  return false
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
  local strikes = self.hearts
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

function GameManagerDefiner:getHearts()
  return self.hearts
end

function GameManagerDefiner:getGuild()
    return self.guild
end

function GameManagerDefiner:getPlayerInGuildT()
  local t = {}
  for i = 1, #self.guild do
    table.insert(t, #t+1, self.guild:getName())
  end
  return t
end

function GameManagerDefiner:getMonth()
  return self.month
end

function GameManagerDefiner:getOutcomeState()
  return self.outcomeState
end

function GameManagerDefiner:getStudent(name)
  for i =1, #allStudents do
    if name == allStudents[i]:getName() then
      return allStudents[i]
    end
  end
  return false
end

function GameManagerDefiner:getActivity(name)
  for i =1, #allActivities do
    if name == allActivities[i]:getName() then
      return allActivities[i]
    end
  end
  return false
end

GameManager = GameManagerDefiner:new()
GameManager:initialize()



return GameManager
