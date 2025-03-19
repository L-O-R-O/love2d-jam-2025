local constants = require("constants")

yearbook = {}

-- Creazione dell'agenda con i nomi
local allNames = {
  -- A-C
  "Alberto Spaghettini", "Anna Klopfenstein", "Akira Nakamoto", "Amina Farouki", "Aarav Choudhary",
  "Bianca Ricottelli", "Barbara Von Pudding", "Beatrice Marshmallow", "Boris Chernobyl", "Bashir Al-Souk",
  "Carlos Tortilla", "Carla Wafflestein", "Cem Baklava", "Chloé Baguettier", "Caoimhe O'McPotato",
  "Charlotte Croissant", "Chen Fengbao", "Cedric Thunderpants", "Camila Arepas", "Connor MacScone",
  "Cristina Churros", "Claudio Marmellata", "Celeste Nebuloni", "Ciro Carbonara", "Chang Dim-Summer",

  -- D-F
  "Davide Linguini", "Daniela Strudelova", "Dinesh Currywalla", "Dominik Strudelmeister", "Diego Nachos",
  "Domenico Raviolini", "Daphne Spritzendorf", "Dmitri Stroganovsky", "Deepak Masalawala", "Dahlia Honeypaws",
  "Elena Cheeseburger", "Elisa Tiramisu", "Emanuele Fettuccini", "Emir Baklavic", "Esmé Eiffelton",
  "Emma Buttercookie", "Enrique Tamales", "Ezra Schmaltz", "Esteban Salsa", "Egor Vodkanov",
  "Fatima Pistachio", "Federica Gelati", "Fabio Tagliatelle", "Fahad Falafelo", "Felix Pretzelmann",

  -- G-I
  "Giacomo Zucchinelli", "Giulia Stellanova", "Giorgio Pizzaiolo", "Gökhan Kebabci", "Gustavo Chimichurri",
  "Gabriella Biscotti", "Gopal Chaatwalla", "Gunther Wurstelberg", "Gonzalo Parrillero", "Ghada Falafelson",
  "Harald Schnitzel", "Henry Fish'nChips", "Hiroshi Ramenaka", "Hafsa Baklavi", "Hans Sauerkrauter",
  "Hassan Hummusfi", "Héctor Salsa", "Hema Laddooli", "Helene Berliner", "Haoran Noodlemeister",
  "Isabella Spumante", "Ibrahim Olivetto", "Ilaria Risottini", "Ivo Sacher", "Ivanka Strudelskaya",

  -- J-M
  "Jacopo Pappardelle", "Jessica Donutson", "Jasmine Lotusblossom", "Javier Tortillero", "Jian Dumpling",
  "Johann Krautheimer", "Jonas Wiener", "Juan Burritazo", "Jacek Pierogowski", "Jibril Dateshake",
  "Kevin BigMacintosh", "Kristian Stroopwaffels", "Khalid Kebabo", "Katia Blinchikov", "Kazuo Tempura",
  "Ksenia Pirozhkova", "Karim Haloumi", "Kiana Cheesetarts", "Kumar Tandoori", "Kimiko Mochizuki",
  "Laura Macaronetti", "Leonardo Limoncello", "Luca Gnocchetti", "Ludovico Tagliatellini", "Lina Baklavia",

  -- N-P
  "Marco Cannoli", "Massimo Pesto", "Marta Crostini", "Matteo Marinaro", "Mehmet Dönerci",
  "Mohammed Halalovich", "Maria Torta", "Ming Baozi", "Marius Kürtőskalács", "Mikhail Borschtinsky",
  "Nicole Tramezzini", "Nadia Oregano", "Noemi Couscous", "Nicolas Cassoulet", "Natasha Vareniki",
  "Nuru Fufu", "Nelson Palmier", "Natsuki Sushi", "Naomi Sashimura", "Nathan Popcornov",
  "Olga Stroganoff", "Oriana Gyoza", "Orlando Paellero", "Oscar Ceviche", "Omar Harira",

  -- Q-S
  "Quentin CroqueMonsieur", "Quirino Tonnarelli", "Quirina Wonton", "Qadir Shawarma", "Quang Pho",
  "Rafael PaoDeQueijo", "Raffaella Tiramisu", "Roberto Tarallucci", "Rosa Dulcedeleche", "Rami Haloumi",
  "Riccardo Cantuccini", "Rashid Tandoori", "Ravi Masalani", "Rene Raclette", "Rasmus Smørrebrød",
  "Sofia Baklavopoulos", "Sara Pastanera", "Selene Bibimbap", "Silvio Grissini", "Simone Profiterole",
  "Sanjay Samosananda", "Satoshi Teriyaki", "Suleiman Kofte", "Santiago Chimichurri", "Seher Pistacchio",

  -- T-V
  "Teresa Montblanc", "Tommaso Tagliata", "Teodoro Gorgonzoli", "Tobia Pannacotta", "Tenzing Momos",
  "Takumi Okonomiyaki", "Tarek Manakish", "Tsubasa Onigiri", "Tania Pierogi", "Tariq Karakchai",
  "Ugo Parmigiano", "Ubaldo Cotechino", "Umberto Grappa", "Ursula Pastizzi", "Umar Papadam",
  "Uzair Halim", "Uday Ramenstein", "Ulrich Sauerbrot", "Uchenna Jollof", "Usman Pakoras",
  "Vanessa Quiche", "Valerio Tiramisushi", "Vittoria Risottini", "Viola Croissantini", "Vladimir Blini",

  -- W-Z
  "Walter Rösti", "Wendy Yorkshire", "Wassim Baklavov", "Wei DimSun", "Wiktor Kielbasa",
  "Winona Frybread", "Wilhelm Strudelmann", "Wahida Maamoul", "Wangari Chapatiman", "Wolfgang Apfelstrudel",
  "Xenia Zhurek", "Xander XiaoLong", "Ximena Tamalitos", "Xin Wok", "Xia Mooncake",
  "Xue Hotpot", "Xavier Meringue", "Xochitl Elote", "Xiaolong Tofu", "Xinyi Sesame",
  "Yari Naan", "Yvonne Bagelson", "Yassir Couscous", "Yuki Dorayaki", "Yusuf Sambusi",
  "Zaira Cannelloni", "Zaccaria Strozzapreti", "Zeynep Kunefe", "Zhao Baiju", "Zubair Lassi"
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
local tabs          = {}
local selectedNames = {}
local namesPerPage  = 10  -- 5 nomi per colonna a sinistra, 5 a destra
local currentPage   = 1
local maxPages      = 1
local clickables    = {}
local prevArrow     = {}
local nextArrow     = {}
local leftX, rightX = 0.20, 0.753
local heightIndex   = 1
local background = constants.IMAGES_YB_AC

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
  for _, name in ipairs(allNames) do
    local firstLetter = name:sub(1, 1)
    if firstLetter >= range[1] and firstLetter <= range[2] then
      table.insert(filtered, name)
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
  local flapsYOffset = 0.28
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
    local yPerc = flapsYOffset + (0.091 * heightIndex)
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
  -- Selezione iniziale
  selectedNames = filterNames(groups[1].range)
  updateMaxPages()
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

function yearbook.draw()
  local alwaysShowArrows = true
  screenManager:drawSceneBackground(background)
  screenManager:drawSceneBackground(constants.IMAGES_YB_ARROWS_NONE,arrowsHoverImgs)
  love.graphics.setFont(constants.FONTS_NICE_CHALK)
  love.graphics.setColor(colorText.r, colorText.g, colorText.b, colorText.a)

  local arrowWidth    = screenManager.screenWidth * 0.06
  local arrowHeight   = screenManager.screenHeight * 0.06
  local centerX       = screenManager.screenWidth / 2

  -- Disegna le linguette
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
      local name = selectedNames[i]
      local y = namesYOffset + (((i - startIdx) % (namesPerPage/2)) * namesYSpacing)
      local x = (i - startIdx) < namesPerPage/2 and (centerX - namesXLeftStart) or (centerX + namesXRightStart)
      love.graphics.print(name, x, y)
    end

  -- Disegna le frecce di navigazione
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
