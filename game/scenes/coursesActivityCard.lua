local constants = require("constants")
coursesActivityCard = {}

-- Cache delle immagini
local images = {
  background = constants.IMAGES_CS_ACTIVITY_CARD_BG
}

-- Cache dei font
local fonts = {
  title = constants.FONTS_NICE_CHALK_TITLE,
  body = constants.FONTS_NICE_CHALK_BODY
}

-- Cache dei colori
local colors = {
  black = {0, 0, 0, 1},
  white = {1, 1, 1, 1},
  red = {1, 0, 0, 1}
}

-- Stato della scena
local state = {
  currentCourse = {
    course = false,
    courseSchedule = ""
  }
}

-- Aree cliccabili
local areas = {
  card = {
    xPerc = 0.31,
    yPerc = 0.375,
    widthPerc = 0.38,
    heightPerc = 0.34
  },
  name = {
    xPerc = 0.445,
    yPerc = 0.44,
    widthPerc = 0.18,
    heightPerc = 0.05
  },
  description = {
    xPerc = 0.395,
    yPerc = 0.57,
    widthPerc = 0.28,
    heightPerc = 0.05
  },
  schedule = {
    xPerc = 0.395,
    yPerc = 0.63,
    widthPerc = 0.28,
    heightPerc = 0.05
  }
}

-- Funzioni di utilità
local function setupAreas()
  for name, area in pairs(areas) do
    areas[name] = screenManager:calcAreaSizes(area)
  end
end

function coursesActivityCard.load()
  mouse.registerHandler(coursesActivityCard, constants.SCENES_COURSES_ACTIVITY_CARD)
  setupAreas()
end

function coursesActivityCard.update(dt)
  state.currentCourse.course = GameManager:getActivity(currentCourse.name)
  if state.currentCourse.course ~= false then
    state.currentCourse.courseSchedule = state.currentCourse.course:getStrSchedule()
  end
end

function coursesActivityCard.keypressed(key)
  if key == constants.KEYS_ESCAPE_MENU then
    scenesManager:setScene(constants.SCENES_COURSES, false)
  elseif key == constants.KEYS_PAUSE_MENU then
    scenesManager:setScene(constants.SCENES_TITLE)
  end
end

function coursesActivityCard.mousePressed(x, y, button)
  if screenManager:checkIfClickingOutside(x, y, areas.card) then
    scenesManager:setScene(constants.SCENES_COURSES, false)
  end
end

function coursesActivityCard.draw()
  -- Imposta il font per il titolo
  love.graphics.setFont(fonts.title)

  -- Disegna lo sfondo
  screenManager:drawSceneBackground(images.background)

  -- Disegna il nome del corso
  love.graphics.setColor(colors.black)
  love.graphics.printf(currentCourse.name, areas.name.x, areas.name.y, areas.name.width, "center")

  -- Disegna la descrizione del corso
  love.graphics.setFont(fonts.body)
  love.graphics.setColor(colors.black)
  love.graphics.printf(currentCourse.description, areas.description.x, areas.description.y, areas.description.width, "left")

  -- Disegna l'orario del corso
  love.graphics.setColor(colors.black)
  love.graphics.printf(state.currentCourse.courseSchedule, areas.schedule.x, areas.schedule.y, areas.schedule.width, "left")

  -- Reset del colore
  love.graphics.setColor(colors.white)
end

return coursesActivityCard
