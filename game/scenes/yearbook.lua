local constants = require("constants")

yearbook = {}

-- Creazione dell'agenda con i nomi
local students = {
  {name = "Alberto Bananovich", description = "Loves to sing in the shower", hobby = "Origami", sport = "Basketball", inGuild = false},
  {name = "Anna Von Sprinkles", description = "Always carries a rubber duck", hobby = "Juggling", sport = "Swimming", inGuild = false},
  {name = "Bianca Thunderfoot", description = "Speaks in rhymes", hobby = "Rock collecting", sport = "Fencing", inGuild = false},
  {name = "Carlo Noodleman", description = "Eats spaghetti with chopsticks", hobby = "Cooking weird dishes", sport = "Table tennis", inGuild = false},
  {name = "Davide McMuffin", description = "Laughs at his own jokes", hobby = "Building model ships", sport = "Rugby", inGuild = false},
  {name = "Elisa Stardust", description = "Has an encyclopedic knowledge of dinosaurs", hobby = "Astrophotography", sport = "Archery", inGuild = false},
  {name = "Francesco O'Pajamas", description = "Wears pajamas all day", hobby = "Writing poetry", sport = "Soccer", inGuild = false},
  {name = "Giorgio Snickerdoodle", description = "Invents weird conspiracy theories", hobby = "Whittling", sport = "Judo", inGuild = false},
  {name = "Luca Moonwalker", description = "Only walks backwards", hobby = "Dancing", sport = "Skateboarding", inGuild = false},
  {name = "Marco Bumblebee", description = "Talks really fast", hobby = "Collecting comics", sport = "Boxing", inGuild = false},
  {name = "Nadia Pickles", description = "Always smells like cinnamon", hobby = "Playing the ukulele", sport = "Skiing", inGuild = false},
  {name = "Olga Waffleton", description = "Has a pet turtle named Steve", hobby = "Sculpting", sport = "Ice skating", inGuild = false},
  {name = "Paolo McZebra", description = "Can whistle any song perfectly", hobby = "Wood carving", sport = "Karate", inGuild = false},
  {name = "Riccardo Fizzlebop", description = "Wears mismatched socks on purpose", hobby = "Painting", sport = "Rowing", inGuild = false},
  {name = "Sara Giggles", description = "Laughs in serious situations", hobby = "Bird watching", sport = "Tennis", inGuild = false},
  {name = "Tommaso Pancakes", description = "Loves breakfast food too much", hobby = "Knitting", sport = "Golf", inGuild = false},
  {name = "Ugo Jellybean", description = "Speaks fluent pirate", hobby = "Brewing coffee", sport = "Badminton", inGuild = false},
  {name = "Vittoria TaterTot", description = "Collects old postcards", hobby = "Calligraphy", sport = "Cycling", inGuild = false},
  {name = "Zeno Cabbagepatch", description = "Can solve a Rubik's cube in under a minute", hobby = "Chess", sport = "Track and field", inGuild = false},
  {name = "Antonio Marshmallow", description = "Never loses at rock-paper-scissors", hobby = "Guitar", sport = "Volleyball", inGuild = false},
  {name = "Beatrice Wiggly", description = "Owns 50 pairs of sunglasses", hobby = "Origami", sport = "Wrestling", inGuild = false},
  {name = "Cesare McQuack", description = "Has a collection of rubber ducks", hobby = "Fishing", sport = "Handball", inGuild = false},
  {name = "Domenico Twizzler", description = "Eats ice cream even in winter", hobby = "Singing", sport = "Surfing", inGuild = false},
  {name = "Emma Zoodle", description = "Can quote every line from her favorite movie", hobby = "Doodling", sport = "Weightlifting", inGuild = false},
  {name = "Filippo Lollington", description = "Loves dad jokes", hobby = "Building LEGO sets", sport = "Pole vaulting", inGuild = false},
  {name = "Ginevra Popcorn", description = "Can recite the alphabet backwards", hobby = "Tattoo designing", sport = "Kayaking", inGuild = false},
  {name = "Harald Snickers", description = "Talks to houseplants", hobby = "Writing haikus", sport = "Dodgeball", inGuild = false},
  {name = "Isabella Flapjack", description = "Wants to learn every language", hobby = "Pottery", sport = "Lacrosse", inGuild = false},
  {name = "Jacopo Pogo", description = "Can play any song on the kazoo", hobby = "Magic tricks", sport = "Bouldering", inGuild = false},
  {name = "Kristian Waffles", description = "Has a pet goldfish named Bob", hobby = "Sewing", sport = "Cricket", inGuild = false},
  {name = "Laura Thunderpants", description = "Afraid of butterflies", hobby = "Baking", sport = "Fencing", inGuild = false},
  {name = "Matteo McTwist", description = "Sleeps with socks on", hobby = "Scrapbooking", sport = "Hockey", inGuild = false},
  {name = "Noemi Soggytoast", description = "Once met a celebrity but didn't recognize them", hobby = "Collecting vintage posters", sport = "Equestrian", inGuild = false},
  {name = "Oscar Wigglytoes", description = "Dances while brushing his teeth", hobby = "Playing piano", sport = "Gymnastics", inGuild = false},
  {name = "Pietro Limoncello", description = "Can do an uncanny duck impression", hobby = "Cosplaying", sport = "Water polo", inGuild = false},
  {name = "Quentin Swoosh", description = "Has never lost a staring contest", hobby = "Building computers", sport = "MMA", inGuild = false},
  {name = "Rosa Bloop", description = "Only drinks iced coffee", hobby = "DIY projects", sport = "Parkour", inGuild = false},
  {name = "Silvio Quirk", description = "Can nap anywhere", hobby = "Sketching", sport = "Javelin throwing", inGuild = false},
  {name = "Teodoro Tumbleweed", description = "Has a lucky penny", hobby = "Hiking", sport = "Rowing", inGuild = false},
  {name = "Ursula Fizz", description = "Never gets sunburned", hobby = "Watching documentaries", sport = "Shooting", inGuild = false},
  {name = "Valerio Doodlepop", description = "Always carries a notebook", hobby = "Embroidery", sport = "Handball", inGuild = false},
  {name = "Wendy Squish", description = "Loves horror movies but gets scared easily", hobby = "Candle making", sport = "Triathlon", inGuild = false},
  {name = "Xander Pudding", description = "Talks to himself in the mirror", hobby = "Cooking", sport = "Windsurfing", inGuild = false},
  {name = "Yvonne Jigglybean", description = "Owns 200 pairs of socks", hobby = "Knitting", sport = "Frisbee", inGuild = false},
  {name = "Zaccaria Floop", description = "Doesn't like chocolate", hobby = "Making funny voices", sport = "Ultimate frisbee", inGuild = false},
  {name = "Abel Funkleton", description = "Collects mismatched socks", hobby = "Calligraphy", sport = "Basketball", inGuild = false},
  {name = "Bea Quokka", description = "Giggles uncontrollably at puns", hobby = "Scrapbooking", sport = "Tennis", inGuild = false},
  {name = "Cyrus Wigglefist", description = "Once ate an entire watermelon", hobby = "Frog watching", sport = "Rugby", inGuild = false},
  {name = "Dina Fizzlesnoot", description = "Owns 40 different scarves", hobby = "Karaoke", sport = "Badminton", inGuild = false},
  {name = "Elliott McMuffins", description = "Can hum two songs at once", hobby = "Puzzle solving", sport = "Table tennis", inGuild = false},
  {name = "Flora Snickerwhistle", description = "Talks to her plants", hobby = "Embroidery", sport = "Track and field", inGuild = false},
  {name = "Gustav O’Pickles", description = "Never loses at rock-paper-scissors", hobby = "Guitar", sport = "Handball", inGuild = false},
  {name = "Hana Stardancer", description = "Has a secret talent for juggling", hobby = "Painting miniatures", sport = "Lacrosse", inGuild = false},
  {name = "Ike Twinkleboots", description = "Laughs at his own jokes", hobby = "Doodling", sport = "Volleyball", inGuild = false},
  {name = "Jasmine Flapdoodle", description = "Loves collecting postcards", hobby = "Candle making", sport = "Ice skating", inGuild = false},
  {name = "Klaus Bumblepants", description = "Can recite Shakespeare backwards", hobby = "Baking", sport = "Skiing", inGuild = false},
  {name = "Lena Taterbop", description = "Always carries at least three snacks", hobby = "Origami", sport = "Cycling", inGuild = false},
  {name = "Miles Quirkendorf", description = "Thinks pineapple belongs on pizza", hobby = "Chess", sport = "Wrestling", inGuild = false},
  {name = "Nina Doodleflop", description = "Invents her own words", hobby = "Cosplay", sport = "Rowing", inGuild = false},
  {name = "Oscar Muffinfeet", description = "Sleeps with socks on", hobby = "Knitting", sport = "Surfing", inGuild = false},
  {name = "Penelope Soggytoes", description = "Afraid of butterflies", hobby = "Writing poetry", sport = "Weightlifting", inGuild = false},
  {name = "Quincy Snorfblat", description = "Can wiggle his ears independently", hobby = "Sculpting", sport = "Fencing", inGuild = false},
  {name = "Renee Marshmellow", description = "Has a lucky coin", hobby = "Tattoo designing", sport = "Parkour", inGuild = false},
  {name = "Sergio Wobbleboots", description = "Loves watching clouds", hobby = "Playing the violin", sport = "Cricket", inGuild = false},
  {name = "Tasha Flibberflop", description = "Speaks fluent pirate", hobby = "Calligraphy", sport = "Frisbee", inGuild = false},
  {name = "Ulrich Squigglefist", description = "Has a pet hamster named Pudding", hobby = "Magic tricks", sport = "Judo", inGuild = false},
  {name = "Valerie Gobblepants", description = "Eats breakfast for dinner", hobby = "DIY projects", sport = "Shooting", inGuild = false},
  {name = "Walter Wumpus", description = "Loves to read random Wikipedia pages", hobby = "Fishing", sport = "Golf", inGuild = false},
  {name = "Xena Jibberjab", description = "Dances like no one is watching", hobby = "Playing the ukulele", sport = "Triathlon", inGuild = false},
  {name = "Yannick Wiggletop", description = "Never steps on cracks in the sidewalk", hobby = "Bird watching", sport = "Water polo", inGuild = false},
  {name = "Zelda Bloopington", description = "Hiccups when nervous", hobby = "Origami", sport = "Dodgeball", inGuild = false},
  {name = "Archibald Swooshtail", description = "Thinks lizards are cool", hobby = "Model building", sport = "Karate", inGuild = false},
  {name = "Bridget Twinklepaws", description = "Can identify trees by their leaves", hobby = "Baking", sport = "Kayaking", inGuild = false},
  {name = "Cecil Whimsyfoot", description = "Loves cheesy romance novels", hobby = "Sewing", sport = "Javelin throwing", inGuild = false},
  {name = "Desdemona Wifflewhirl", description = "Writes secret notes to herself", hobby = "Calligraphy", sport = "Archery", inGuild = false},
  {name = "Ephraim Snorkelstein", description = "Is really good at trivia", hobby = "Knitting", sport = "Equestrian", inGuild = false},
  {name = "Fiona McToots", description = "Laughs at inappropriate moments", hobby = "Glassblowing", sport = "MMA", inGuild = false},
  {name = "Gilbert Fizzlebop", description = "Has an entire closet dedicated to hats", hobby = "Building LEGO", sport = "Pole vaulting", inGuild = false},
  {name = "Harriet Muffinwhisk", description = "Can balance a spoon on her nose", hobby = "Scrapbooking", sport = "Handball", inGuild = false},
  {name = "Ivy Gigglequack", description = "Loves roller coasters but hates heights", hobby = "Painting", sport = "Dodgeball", inGuild = false},
  {name = "Jasper Tiddlywink", description = "Always whistles while walking", hobby = "Tattoo designing", sport = "Rowing", inGuild = false},
  {name = "Kendrick Wobblepaws", description = "Sings in the shower like a rockstar", hobby = "Brewing coffee", sport = "Lacrosse", inGuild = false},
  {name = "Lillian Pancakebottom", description = "Can do a perfect cartwheel", hobby = "Writing haikus", sport = "Skateboarding", inGuild = false},
  {name = "Mortimer Quackfoot", description = "Still believes in Santa", hobby = "Watching classic movies", sport = "Fencing", inGuild = false},
  {name = "Nellie Jumblebean", description = "Has a weird talent for balancing things", hobby = "Collecting keychains", sport = "Ice skating", inGuild = false},
  {name = "Olivier Fumbleton", description = "Only eats the crusts of sandwiches", hobby = "Magic tricks", sport = "Weightlifting", inGuild = false},
  {name = "Petra Snickerdoodle", description = "Always forgets where she put her keys", hobby = "Chess", sport = "Swimming", inGuild = false},
  {name = "Quinton Lollygagger", description = "Can fold a paper crane in 10 seconds", hobby = "Doodling", sport = "Skiing", inGuild = false},
  {name = "Rosalie Tiddlybop", description = "Refuses to eat blue foods", hobby = "Journaling", sport = "Ultimate Frisbee", inGuild = false},
  {name = "Sebastian Waddlequack", description = "Talks to himself in the mirror", hobby = "Astrophotography", sport = "Cricket", inGuild = false}
}


-- Creazione dei gruppi
local groups = {
  {label = "A-C", range = {"A", "C"}, background = constants.IMAGES_YB_AC},
  {label = "D-F", range = {"D", "F"}, background = constants.IMAGES_YB_DF},
  {label = "G-I", range = {"G", "I"}, background = constants.IMAGES_YB_GI},
  {label = "J-M", range = {"J", "M"}, background = constants.IMAGES_YB_JM},
  {label = "N-P", range = {"N", "P"}, background = constants.IMAGES_YB_NP},
  {label = "Q-S", range = {"Q", "S"}, background = constants.IMAGES_YB_QS},
  {label = "T-V", range = {"T", "V"}, background = constants.IMAGES_YB_TV},
  {label = "W-Z", range = {"W", "Z"}, background = constants.IMAGES_YB_WZ}
}

-- Hover dei bottoni prevArrow e nextArrow
local arrowsHoverImgs = {
  PREV_BUTTON  = constants.IMAGES_YB_ARROWS_LEFT,
  NEXT_BUTTON = constants.IMAGES_YB_ARROWS_RIGHT
}

local colorText   = {r = 0, g = 0, b = 0, a = 1}  -- Nero

-- Variabili per la gestione dell'interfaccia
local tabs           = {}
local yearbookLabels = {}
local selectedNames  = {}
local namesPerPage   = 10  -- 5 nomi per colonna a sinistra, 5 a destra
local currentPage    = 1
local maxPages       = 1
local clickables     = {}
local prevArrow      = {}
local nextArrow      = {}
local leftX, rightX  = 0.20, 0.753
local heightIndex    = 1
local background     = constants.IMAGES_YB_AC

local function PREV_PAGE()
  if currentPage > 1 then
    currentPage = currentPage - 1
  end
end

local function NEXT_PAGE()
  if currentPage < maxPages then
    currentPage = currentPage + 1
  end
end

-- Funzione per filtrare i nomi in base al gruppo selezionato
function filterNames(range)
  local filtered = {}
  for _, student in ipairs(students) do
    local firstLetter = student.name:sub(1, 1)
    if firstLetter >= range[1] and firstLetter <= range[2] then
      table.insert(filtered, student)
    end
  end
  return filtered
end

-- Aggiorna il numero massimo di pagine disponibili
function updateMaxPages()
  maxPages = math.max(1, math.ceil(#selectedNames / namesPerPage))
  currentPage = 1  -- Reset alla prima pagina quando si cambia gruppo
end

function yearbook.drawPage()
  mouse.registerHandler(yearbook, constants.SCENES_YEARBOOK)
  -- Definizione frecce navigazione
  prevArrow = {
    name        = 'PREV_BUTTON',
    xPerc       = 0.12,
    yPerc       = 0.52,
    widthPerc   = 0.06,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  nextArrow = {
    name        = 'NEXT_BUTTON',
    xPerc       = 0.82,
    yPerc       = 0.52,
    widthPerc   = 0.06,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, prevArrow, prevArrow.name, PREV_PAGE)
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, nextArrow, nextArrow.name, NEXT_PAGE)
  heightIndex = 1
  local tabsYOffset = 0.28
  local screenHeight = screenManager.screenWidth
  local tabHeight = screenHeight / 5
  for i, group in ipairs(groups) do
    if i == 6 then
      -- Resetto l'indice per disegnare le linguette
      -- Cinque linguette a sx, tre a dx
      -- In questo modo la sesta linguetta verrá disegnata a dx
      heightIndex = 1
    end
    -- Calcolo la posizione delle linguette
    local xPerc = (i < 6) and leftX or rightX
    local yPerc = tabsYOffset + (0.091 * heightIndex)
    heightIndex = heightIndex + 1

    local widthPerc = 0.05
    local heightPerc = 0.06
    local clickableArea = {
      name        = group.label,
      xPerc       = xPerc,
      yPerc       = yPerc,
      widthPerc   = widthPerc,
      heightPerc  = heightPerc,
      x           = 0,
      y           = 0,
      width       = 0,
      height      = 0,
    }
    table.insert(tabs, clickableArea)
    screenManager:setClickableArea(constants.SCENES_YEARBOOK, clickableArea, constants.SCENES_YEARBOOK)
  end
  -- Selezione iniziale dei nomi
  selectedNames = filterNames(groups[1].range)
  updateMaxPages()

  -- Crea le aree cliccabili delle etichette
  local heightIndex = 1
  local columns = 2
  local totalItems = 10
  local rowsPerColumn = totalItems / columns

  local tabsYOffset = 0.26  -- Starting Y position (28% from top)
  local screenWidth = screenManager.screenWidth
  local centerX = screenWidth / 2  -- Center of the screen

  local boxWidthPerc = 0.18  -- 5% of the screen width
  local boxHeightPerc = 0.08 -- 6% of the screen height
  local columnSpacingPerc = 0.09 -- 2% gap between columns

  -- Calculate X positions for the two columns
  local leftX = centerX - (boxWidthPerc * screenWidth) - (columnSpacingPerc * screenWidth / 2)
  local rightX = centerX + (columnSpacingPerc * screenWidth / 2)

  for i = 1, totalItems do
      if i == rowsPerColumn + 1 then
          -- Reset height index for second column
          heightIndex = 1
      end

      -- Determine column position
      local xPerc = (i <= rowsPerColumn) and leftX or rightX
      local yPerc = tabsYOffset + (0.095 * heightIndex) -- Adjust vertical spacing
      heightIndex = heightIndex + 1

      local clickableLabel = {
          name = "Box " .. i,
          student = nil,
          xPerc = xPerc / screenWidth,
          yPerc = yPerc,
          widthPerc = boxWidthPerc,
          heightPerc = boxHeightPerc,
          x = 0,
          y = 0,
          width = 0,
          height = 0,
      }
      table.insert(yearbookLabels, clickableLabel)
      screenManager:setClickableArea(constants.SCENES_YEARBOOK, clickableLabel, constants.SCENES_YEARBOOK)
  end
end

function yearbook.load()
  yearbook.drawPage()
end

function yearbook.update(dt)

end

function yearbook.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key =='c') then
    scenesManager:setScene(constants.SCENES_CALENDAR)
  elseif (key =='f') then
    scenesManager:setScene(constants.SCENES_COURSES)
  elseif (key =='j') then
    scenesManager:setScene(constants.SCENES_AGENDA)
  elseif (key =='l') then
    yearbook.drawPage() --!!!DEBUG!!!
  end
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  end
end

function yearbook.drawRedBoxes()
  love.graphics.setColor(1, 0, 0) -- Red color
  for _, box in ipairs(yearbookLabels) do
      love.graphics.rectangle("line", box.x, box.y, box.width, box.height)
      love.graphics.printf(box.student.name, box.x, box.y, 350)
  end
  love.graphics.setColor(0, 0, 0) -- Reset color to black
end

function yearbook.draw()
  local alwaysShowArrows = true
  screenManager:drawSceneBackground(background)
  screenManager:drawSceneBackground(constants.IMAGES_YB_ARROWS_NONE,arrowsHoverImgs)
  love.graphics.setFont(constants.FONTS_NICE_CHALK)
  love.graphics.setColor(colorText.r, colorText.g, colorText.b, colorText.a)

  local arrowWidth    = screenManager.screenWidth * 0.06
  local arrowHeight   = screenManager.screenHeight * 0.06
  local centerX       = screenManager.screenWidth / 2

  -- DEBUG disegna le aree delle linguette
  --[[ for _, tab in ipairs(tabs) do
    love.graphics.rectangle("line", tab.x, tab.y, tab.width, tab.height)
    love.graphics.printf(tab.name, tab.x, tab.y + tab.height / 2 - 10, tab.width, "center")
  end ]]
  -- Calcola le posizioni centrate per i nomi
  local namesYOffset     = screenManager.screenHeight * 0.38
  local namesYSpacing    = screenManager.screenHeight * 0.094
  local namesXLeftStart  = screenManager.screenHeight * 0.31
  local namesXRightStart = screenManager.screenHeight * 0.16
  local startIdx = (currentPage - 1) * namesPerPage + 1
  local endIdx = math.min(startIdx + namesPerPage - 1, #selectedNames)

  for i = startIdx, endIdx do
    local name = selectedNames[i].name
    local y = namesYOffset + (((i - startIdx) % (namesPerPage/2)) * namesYSpacing)
    local x = (i - startIdx) < namesPerPage/2 and (centerX - namesXLeftStart) or (centerX + namesXRightStart)
    love.graphics.print(name, x, y)
    yearbookLabels[i].student = selectedNames[i]
  end

  --yearbook.drawRedBoxes()

  -- DEBUG: disegna le aree PREV e NEXT
  if maxPages > 1 then
    if currentPage ~= 1 or alwaysShowArrows then
      --love.graphics.setColor(1, 0, 0, 1)
      --love.graphics.rectangle("line",prevArrow.x, prevArrow.y, prevArrow.width, prevArrow.height)
      --love.graphics.printf("Prev", prevArrow.x, prevArrow.y, arrowWidth/2)
    end
    if currentPage < maxPages or alwaysShowArrows then
        --love.graphics.rectangle("line",nextArrow.x, nextArrow.y, nextArrow.width, nextArrow.height)
        --love.graphics.printf("Next", nextArrow.x, nextArrow.y, arrowWidth/2)
    end
  end
  -- Reset del colore per evitare effetti indesiderati
  love.graphics.setColor(1, 1, 1, 1)
end

function yearbook.mousePressed(x, y, button)
  -- Controlla se è stata cliccata una linguetta o una freccia di navigazione
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
  if (clickableAreaName) then
    soundsManager:playClickOnComputerScreen()
    for _, tab in ipairs(tabs) do
      if x >= tab.x and x <= tab.x + tab.width and y >= tab.y and y <= tab.y + tab.height then
        local range = ''
        for _, group in ipairs(groups) do
          if group.label == tab.name then
            range = group.range
            background = group.background
            break
          end
        end
        selectedNames = filterNames(range)
        updateMaxPages()
        return
      end
    end
  end
end

function yearbook.mouseHovered(x, y)
  if (isClicked) then
    return
  end
  love.graphics.clear()
  local clickableAreaName = screenManager:checkIfIsClickable(x, y, "hover")
  if (clickableAreaName) then
    isHovered = true
    hoveredArea = clickableAreaName
    mouse.loadCursor(constants.HAND_CURSOR)
  else
    isHovered = false
    hoveredArea = nil
    mouse.loadCursor(constants.DEFAULT_CURSOR)
  end
end

return yearbook
