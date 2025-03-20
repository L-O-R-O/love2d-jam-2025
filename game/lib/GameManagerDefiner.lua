GameManagerDefiner = {}
GameManagerDefiner.__index = GameManagerDefiner

require("lib.Player")
constants = require("../constants")

local function getMonthFromOS()
  local monthString = os.date("%m")
  local monthNumber = tonumber(monthString)
  return monthNumber
end

function GameManagerDefiner:new(strikes)
    local obj = {
        strikes = strikes,
        guild = {},
        actualCycle = 10, --0 se non in partita, poi da 1 a 10
        prob = 0, --OPT
        suddenOn = 0, --variabile per capire se mostrare o meno la pagina degli orari
        gameOver = 0,
        month = getMonthFromOS(),
        consecutiveWins=0
    }
    setmetatable(obj, GameManagerDefiner)
    return obj
end

function GameManagerDefiner:getStrikes()
    return self.strikes
end

function GameManagerDefiner:getMonth()
    return self.month
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
    end
    if(self.consecutiveWins==2)then
        self:addInGuild(self:findSuitablePlayer())
        self.consecutiveWins = 0
    end
end

GameManager = GameManagerDefiner:new(2)

return GameManager
