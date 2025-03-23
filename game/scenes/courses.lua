local constants = require("constants")
courses = {}

local allCourses = constants.ACTIVITIES
--[[ {
  { name = "Rugby", description = "A physical team sport played with an oval ball.", calendar = {}, dayOfTheWeek = "1", strSchedule = {} },
  { name = "Soccer", description = "A popular sport played with a round ball on a field.", calendar = {}, dayOfTheWeek = "2", strSchedule = {} },
  { name = "Basketball", description = "A team sport where players try to score points in a hoop.", calendar = {}, dayOfTheWeek = "3", strSchedule = {} },
  { name = "Volleyball", description = "A net game where teams aim to land the ball on the opponent's side.", calendar = {}, dayOfTheWeek = "4", strSchedule = {} },
  { name = "Tennis", description = "A racket sport played individually or in pairs.", calendar = {}, dayOfTheWeek = "5", strSchedule = {} },
  { name = "Chess Club", description = "A strategic board game played by two people.", calendar = {}, dayOfTheWeek = "1", strSchedule = {} },
  { name = "Debate Club", description = "A club where students discuss and argue various topics.", calendar = {}, dayOfTheWeek = "2", strSchedule = {} },
  { name = "Drama Club", description = "A group for students interested in acting and stage performances.", calendar = {}, dayOfTheWeek = "3", strSchedule = {} },
  { name = "Photography Club", description = "A club for students passionate about capturing images.", calendar = {}, dayOfTheWeek = "4", strSchedule = {} },
  { name = "Music Band", description = "A group where students play musical instruments together.", calendar = {}, dayOfTheWeek = "5", strSchedule = {} },
  { name = "Swimming", description = "A water sport focused on various strokes and endurance.", calendar = {}, dayOfTheWeek = "1", strSchedule = {} },
  { name = "Martial Arts", description = "A combat sport that includes techniques from different disciplines.", calendar = {}, dayOfTheWeek = "2", strSchedule = {} },
  { name = "Running Club", description = "A group dedicated to jogging and marathon training.", calendar = {}, dayOfTheWeek = "3", strSchedule = {} },
  { name = "Yoga", description = "A practice focused on flexibility, breathing, and relaxation.", calendar = {}, dayOfTheWeek = "4", strSchedule = {} },
  { name = "Coding Club", description = "A place for students to practice and learn programming.", calendar = {}, dayOfTheWeek = "5", strSchedule = {} },
  { name = "Literary Society", description = "A club for book lovers and writers.", calendar = {}, dayOfTheWeek = "1", strSchedule = {} },
  { name = "Environmental Club", description = "A group focused on sustainability and green initiatives.", calendar = {}, dayOfTheWeek = "2", strSchedule = {} },
  { name = "Astronomy Club", description = "A club dedicated to stargazing and learning about the universe.", calendar = {}, dayOfTheWeek = "3", strSchedule = {} },
  { name = "Dance Crew", description = "A group for students passionate about dancing.", calendar = {}, dayOfTheWeek = "4", strSchedule = {} },
  { name = "Robotics Club", description = "A club for students interested in building and programming robots.", calendar = {}, dayOfTheWeek = "5", strSchedule = {} },
  { name = "Science Club", description = "A group dedicated to scientific experiments and discussions.", calendar = {}, dayOfTheWeek = "1", strSchedule = {} },
  { name = "Drama Workshop", description = "A place to learn acting and stage performance skills.", calendar = {}, dayOfTheWeek = "2", strSchedule = {} },
  { name = "Music Choir", description = "A choir group for students who love singing.", calendar = {}, dayOfTheWeek = "3", strSchedule = {} },
  { name = "Film Making Club", description = "A club for students interested in directing and producing films.", calendar = {}, dayOfTheWeek = "4", strSchedule = {} },
  { name = "First Aid Training", description = "A program teaching emergency medical response.", calendar = {}, dayOfTheWeek = "5", strSchedule = {} },
  { name = "Parkour Training", description = "A sport focused on overcoming obstacles efficiently.", calendar = {}, dayOfTheWeek = "1", strSchedule = {} },
  { name = "E-Sports Team", description = "A group competing in video game tournaments.", calendar = {}, dayOfTheWeek = "2", strSchedule = {} },
  { name = "Public Speaking Club", description = "A club for students to improve their oratory skills.", calendar = {}, dayOfTheWeek = "3", strSchedule = {} },
  { name = "Board Games Club", description = "A club where students play and discuss board games.", calendar = {}, dayOfTheWeek = "4", strSchedule = {} },
  { name = "Archery", description = "A sport focused on accuracy using bows and arrows.", calendar = {}, dayOfTheWeek = "5", strSchedule = {} },
  { name = "Rock Climbing", description = "An adventure sport that involves climbing steep surfaces.", calendar = {}, dayOfTheWeek = "1", strSchedule = {} },
  { name = "Survival Skills Club", description = "A group focused on wilderness survival techniques.", calendar = {}, dayOfTheWeek = "2", strSchedule = {} },
  { name = "Creative Writing", description = "A club for students to develop their storytelling skills.", calendar = {}, dayOfTheWeek = "3", strSchedule = {} },
  { name = "Social Work Club", description = "A group focused on volunteering and helping the community.", calendar = {}, dayOfTheWeek = "4", strSchedule = {} },
  { name = "Economics Society", description = "A club discussing financial and economic topics.", calendar = {}, dayOfTheWeek = "5", strSchedule = {} },
  { name = "Coding Hackathons", description = "A club that organizes coding challenges and competitions.", calendar = {}, dayOfTheWeek = "1", strSchedule = {} },
  { name = "Meditation Club", description = "A group dedicated to mindfulness and mental relaxation.", calendar = {}, dayOfTheWeek = "2", strSchedule = {} },
  { name = "Linguistics Club", description = "A club for students interested in learning and discussing languages.", calendar = {}, dayOfTheWeek = "3", strSchedule = {} }
} ]]

local browserTabYB   = {}
local browserTabCS   = {}
local prevArrow      = {}
local nextArrow      = {}
local backArrow      = {}
local coursesLabels  = {}
local currentPage    = 1
local maxViewCourses = 13
local maxPages       = #allCourses / maxViewCourses
local reDrawAreas   = false

-- Hover dei bottoni prevArrow e nextArrow
local arrowsHoverImgs = {
  PREV_BUTTON  = constants.IMAGES_CS_ARROWS_LEFT,
  NEXT_BUTTON = constants.IMAGES_CS_ARROWS_RIGHT
}

-- Handlers degli elementi activities/courses
local function HANDLE_BROWSER_TAB_CLICK(browserTabArea)
  if browserTabArea.name == "TAB_YB" then
    scenesManager:setScene(constants.SCENES_YEARBOOK,false)
  elseif browserTabArea.name == "TAB_CS" then
    -- does nothing se non il click sound!!
  end
end

local function PREV_PAGE()
  if currentPage > 1 then
    currentPage = currentPage - 1
    reDrawAreas = true
  end
end

local function NEXT_PAGE()
  if currentPage < maxPages then
    currentPage = currentPage + 1
    reDrawAreas = true
  end
end

local function BACK_TO_DESKTOP()
  screenManager:setScene(constants.SCENES_DESKTOP)
end

local function HANDLE_LABEL_CLICK(labelArea)
  if (labelArea.course ~= nil) then
    currentCourse = labelArea.course
    scenesManager:setScene(constants.SCENES_COURSES_ACTIVITY_CARD,false)
  end
end

-- LOVE FUNCTIONS
function courses.load()
  mouse.registerHandler(courses, constants.SCENES_COURSES)
  courses.drawPage()
end

function courses.update(dt)

end

function courses.drawPage()
  screenManager.areas[constants.SCENES_COURSES] = {}
  -- Definizione aree cliccabili fisse
  browserTabYB = {
    name        = 'TAB_YB',
    xPerc       = 0.12,
    yPerc       = 0.1,
    widthPerc   = 0.20,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  browserTabCS = {
    name        = 'TAB_CS',
    xPerc       = 0.32,
    yPerc       = 0.1,
    widthPerc   = 0.20,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  prevArrow = {
    name        = 'PREV_BUTTON',
    xPerc       = 0.455,
    yPerc       = 0.765,
    widthPerc   = 0.05,
    heightPerc  = 0.08,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  nextArrow = {
    name        = 'NEXT_BUTTON',
    xPerc       = 0.60,
    yPerc       = 0.77,
    widthPerc   = 0.05,
    heightPerc  = 0.08,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  backArrow = {
    name        = 'BACK_BUTTON',
    xPerc       = 0.81,
    yPerc       = 0.87,
    widthPerc   = 0.12,
    heightPerc  = 0.1,
    x           = 0,
    y           = 0,
    width       = 0,
    height      = 0,
  }
  screenManager:setClickableArea(constants.SCENES_COURSES, prevArrow, prevArrow.name, PREV_PAGE)
  screenManager:setClickableArea(constants.SCENES_COURSES, nextArrow, nextArrow.name, NEXT_PAGE)
  screenManager:setClickableArea(constants.SCENES_YEARBOOK, backArrow, backArrow.name, BACK_TO_DESKTOP)
  screenManager:setClickableArea(constants.SCENES_COURSES, browserTabYB, browserTabYB.name, function()
    HANDLE_BROWSER_TAB_CLICK(browserTabYB)
  end, {
    browserTab = browserTabYB
  })
  screenManager:setClickableArea(constants.SCENES_COURSES, browserTabCS, browserTabCS.name, function()
    HANDLE_BROWSER_TAB_CLICK(browserTabCS)
  end, {
    browserTab = browserTabCS
  })

  -- Aree cliccabili con oggetti (Labels/Etichette attività)
  coursesLabels        = {} -- Svuota
  local labelOffsetX   = 0  --screenManager.screenWidth  * 0.036
  local labelOffsetY   = screenManager.screenHeight * 0.0115
  local startIdx       = (currentPage - 1) * maxViewCourses + 1
  local endIdx         = math.min(startIdx + maxViewCourses - 1, #allCourses)
  local currentCourses = {}
  local j = 1

  for i = startIdx, endIdx do
    currentCourses[j] = orderedActivities[i]
    j = j + 1
  end

  -- disegna le etichette
  for i = 1, maxViewCourses, 1 do
    if currentCourses[i] ~= nil then
      local coursesLabel = {
        name        = 'Course Label '..i,
        course      = currentCourses[i],
        xPerc       = i <= 6 and 0.193 or 0.435,
        yPerc       = i <= 6 and ((i * 0.062) + 0.40) or (((i-6) * 0.052) + 0.3),
        widthPerc   = i<=6 and 0.165 or 0.165,
        heightPerc  = i<=6 and 0.05 or 0.04,
        x           = 0,
        y           = 0,
        width       = 0,
        height      = 0,
        offsetX     = labelOffsetX,
        offsetY     = labelOffsetY
      }
      screenManager:setClickableArea(constants.SCENES_COURSES, coursesLabel, coursesLabel.name, function()
        HANDLE_LABEL_CLICK(coursesLabel)
      end, {
        coursesLabel = coursesLabel
      })
      table.insert(coursesLabels, coursesLabel)
    end
  end
  reDrawAreas = true
end

function courses.draw()
  love.graphics.setFont(constants.FONTS_NICE_CHALK)
  screenManager:drawSceneBackground(constants.IMAGES_CS_BG)
  screenManager:drawSceneBackground(constants.IMAGES_CS_ARROWS_NONE,arrowsHoverImgs)
  if reDrawAreas then
    courses.drawPage()
    reDrawAreas = false
  end
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.setColor(1, 1, 1, 1)
  for i, coursesLabel in ipairs(coursesLabels) do
    if isHovered and hoveredArea == coursesLabel.name then
      love.graphics.setColor(0.687, 0.477, 0.461, 1)
    else
      love.graphics.setColor(0.409, 0.225, 0.214, 1)
    end
    --love.graphics.rectangle("line", coursesLabel.x, coursesLabel.y, coursesLabel.width, coursesLabel.height)
    --print("Course Label:", coursesLabel.course and coursesLabel.course.name or "MISSING NAME")
    --print("X:", coursesLabel.x, "Y:", coursesLabel.y, "Width:", coursesLabel.width)
    love.graphics.printf(coursesLabel.course.name, coursesLabel.x , coursesLabel.y + coursesLabel.offsetY, coursesLabel.width, "center",-0.002)
  end
  love.graphics.setColor(1, 1, 1, 1)
end

function courses.keypressed(key)
  if (key == constants.KEYS_ESCAPE_MENU) then
    scenesManager:setScene(constants.SCENES_DESKTOP)
  elseif (key == constants.KEYS_PAUSE_MENU) then
    scenesManager:setScene(constants.SCENES_TITLE)
  --[[elseif (key == "y") then
    --courses.drawPage() ]]
  end
end

function courses.mousePressed(x, y, button)
  -- Controlla se è stata cliccata una linguetta o una freccia di navigazione
  local clickableAreaName = screenManager:checkIfIsClickable(x, y)
  if (clickableAreaName) then
    soundsManager:playClickOnComputerScreen()

  end
end

function courses.mouseHovered(x, y)
  if (isClicked) then
    return
  end
  love.graphics.clear()
  local clickableAreaName = screenManager:checkIfIsClickable(x, y, "hover")
  if (clickableAreaName) then
    isHovered = true
    hoveredArea = clickableAreaName.to
    mouse.loadCursor(constants.HAND_CURSOR)
  else
    isHovered = false
    hoveredArea = nil
    mouse.loadCursor(constants.DEFAULT_CURSOR)
  end
end

function drawDebugFrame(stateName,area)
  local colorRect   = {r = 0, g = 0, b = 1, a = 1}  -- Blu
  local colorText   = {r = 0, g = 0, b = 0, a = 1}  -- Nero
  local padding     = 20
  local frameWidth  = area.width
  local frameHeight = area.height

  -- Imposta il colore del rettangolo
  love.graphics.setColor(colorRect.r, colorRect.g, colorRect.b, colorRect.a)

  -- Disegna il rettangolo attorno alla viewport con padding
  love.graphics.rectangle("line", area.x, area.y, frameWidth - 2 * padding, frameHeight - 2 * padding)

  -- Imposta il colore del testo
  love.graphics.setColor(colorText.r, colorText.g, colorText.b, colorText.a)

  -- Scrive la variabile nell'angolo in alto a sinistra
  love.graphics.setFont(constants.FONTS_NICE_CHALK)
  love.graphics.print("Debug: " .. tostring(stateName), area.x + 10, area.y + 10)

  -- Reset del colore per evitare effetti indesiderati
  love.graphics.setColor(1, 1, 1, 1)
end

return courses
