local constants = require("constants")

agenda = {}

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

local function getStrikes()
  return GameManager:getStrikes()
end

function agenda.load()
  mouse.registerHandler(agenda, constants.SCENES_AGENDA)
end

function agenda.update(dt)

end

function agenda.draw()
  local strikes = getStrikes()
  if (strikes == 0) then
    screenManager:drawSceneBackground(constants.IMAGES_AGENDA_BG_FULL)
  elseif (strikes == 1) then
    screenManager:drawSceneBackground(constants.IMAGES_AGENDA_BG_STRIKE_1)
  elseif (strikes == 2) then
    screenManager:drawSceneBackground(constants.IMAGES_AGENDA_BG_STRIKE_2)
  end

  for i, player in ipairs(players) do
    local column = (i - 1) % 2
    local row = math.floor((i - 1) / 2)
    local x = 430 + column * 200
    local y = 480 + row * 75

    -- Draw player name
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(player.name, x + 100, y)

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
end

function agenda.mouseHovered(x, y)
  -- print('AGENDA mousehovered')
end

return agenda
