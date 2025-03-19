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
        gameOver=0
    }
    setmetatable(obj, GameManagerDefiner)
    return obj
end

function GameManagerDefiner:addInGuild(player)
    self.guild[#self.guild + 1] = player
    print(#self.guild)
end

function GameManagerDefiner:updateProb() --OPT
    local strikes = self.strikes
    local guildSize = #self.guild
    local actualCycle = self.actualCycle
    --self.prob = ((guildSize/(strikes+1))*(dt/60)*actualCycle)/100 Qua intendo dt come secondi passati
    self.prob = ((guildSize/(strikes+1))*(120/60)*actualCycle)/100 --QUESTA RIGA PER TEST
    print("PROBABILITA'",self.prob)

end

function GameManagerDefiner:suddenGenerate() --OPT funzione che ogni tot tempo passato nel ciclo tenta di generare un numero per stabilire se far verificare l'imprevisto
    rand=math.random()
    print("RANDOM: ",rand)
    if rand  < self.prob then
        --logica per imprevisto
        self.prob=0
    else
    end
end

function GameManagerDefiner:tryDate(proposedDate)
    for i, player in pairs(self.guild) do
            if not player:checkAvailability(proposedDate) then
                self.strikes=self.strikes+1
            end
    end
    if(self.strikes>=4)then
        self.gameOver=1
    end
end

-- creazione immediata dell'istanza globale
GameManager = GameManagerDefiner:new(0)

return GameManager
