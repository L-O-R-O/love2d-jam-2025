local constants = require("constants")

agenda = {}

local agendaArea = {}

local players = {
  {
    name = "Alice",
    description = "A curious explorer",
    hobby = "Painting",
    sport = "Tennis",
    inGuild = true,
    avatar = "assets/avatars/alice.png"
  },
  {
    name = "Bob",
    description = "A tech enthusiast",
    hobby = "Coding",
    sport = "Basketball",
    inGuild = false,
    avatar = "assets/avatars/bob.png"
  },
  {
    name = "Charlie",
    description = "A nature lover",
    hobby = "Hiking",
    sport = "Soccer",
    inGuild = true,
    avatar = "assets/avatars/charlie.png"
  },
  {
    name = "Diana",
    description = "A bookworm",
    hobby = "Reading",
    sport = "Swimming",
    inGuild = false,
    avatar = "assets/avatars/diana.png"
  },
  {
    name = "Eve",
    description = "A music enthusiast",
    hobby = "Guitar",
    sport = "Volleyball",
    inGuild = true,
    avatar = "assets/avatars/eve.png"
  },
  {
    name = "Frank",
    description = "A gaming pro",
    hobby = "Gaming",
    sport = "Baseball",
    inGuild = false,
    avatar = "assets/avatars/frank.png"
  },
  {
    name = "Grace",
    description = "A creative artist",
    hobby = "Sketching",
    sport = "Badminton",
    inGuild = true,
    avatar = "assets/avatars/grace.png"
  }
}

local guilders = {}

local function getHearts()
  return GameManager:getHearts()
end

function agenda.load()
  mouse.registerHandler(agenda, constants.SCENES_AGENDA)
end

function agenda.update(dt)
  local numberOfLoadGuilders = #guilders
  local gameManagerGuilders = GameManager:getGuild()
  local numberOfManagerGuilders = #gameManagerGuilders

  local t = math.max(numberOfLoadGuilders, numberOfManagerGuilders)
  for i = 1, t do
    if i <= numberOfManagerGuilders then
      local nomeCompleto = gameManagerGuilders[i]:getName()
      local posizioneSpazio = nomeCompleto:find(" ")
      guilders[i] = string.sub(nomeCompleto, 1, posizioneSpazio)
    else
      guilders[i] = ""
    end
  end
end

function agenda.draw()
  local hearts = getHearts()
  if (hearts == 3) then
    screenManager:drawSceneBackground(constants.IMAGES_AGENDA_BG_FULL)
  elseif (hearts == 2) then
    screenManager:drawSceneBackground(constants.IMAGES_AGENDA_BG_STRIKE_1)
  elseif (hearts == 1) then
    screenManager:drawSceneBackground(constants.IMAGES_AGENDA_BG_STRIKE_2)
  end

  agendaArea = screenManager:calcAreaSizes({
    xPerc = 0.17,
    yPerc = 0.15,
    widthPerc = 0.65,
    heightPerc = 0.77
  })
  love.graphics.setColor(0, 0, 1)
  --love.graphics.rectangle("line",agendaArea.x,agendaArea.y,agendaArea.width,agendaArea.height)
  love.graphics.setColor(1, 1, 1)

  for i, player in ipairs(guilders) do
    local column = (i - 1) % 2
    local row = math.floor((i - 1) / 2)
    local x = 430 + column * 200
    local y = 480 + row * 75

    -- Draw player name
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(player, x + 100, y)

    -- Reset color
    love.graphics.setColor(1, 1, 1)
  end
end

function agenda.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function agenda.mousePressed(x, y, button)
  print('AGENDA mousepressed')
  if screenManager:checkIfClickingOutside(x,y,agendaArea) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  end
end

function agenda.mouseHovered(x, y)
  -- print('AGENDA mousehovered')
end

return agenda
