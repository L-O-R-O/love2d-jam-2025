local constants = {}

-- fonts
constants.FONTS_MAIN_MENU = love.graphics.newFont("assets/font/NiceChalk.ttf", 50)
constants.FONTS_SUB_MENU  = love.graphics.newFont("assets/font/NiceChalk.ttf", 40)
constants.FONTS_ROBOTO    = love.graphics.newFont("assets/font/Roboto-Black.ttf", 20)
constants.FONTS_NICE_CHALK = love.graphics.newFont("assets/font/NiceChalk.ttf", 20)

-- images
constants.IMAGES_HOVER_DESKTOP_COMPUTER    = love.graphics.newImage("assets/images/hover_desktop_pc.png")
constants.IMAGES_HOVER_DESKTOP_CALENDAR    = love.graphics.newImage("assets/images/hover_desktop_calendario.png")
constants.IMAGES_HOVER_DESKTOP_AGENDA      = love.graphics.newImage("assets/images/hover_desktop_agenda.png")
constants.IMAGES_DESKTOP_BG                = love.graphics.newImage("assets/images/desktop.png")
constants.IMAGES_COMPUTER_BG               = love.graphics.newImage("assets/images/provazoom_pc.png")
constants.IMAGES_CALENDAR_BG               = love.graphics.newImage("assets/images/prova_calendario.png")
constants.IMAGES_AGENDA_BG                 = love.graphics.newImage("assets/images/provazoom_calendario.png")
constants.IMAGES_CURSOR                    = love.graphics.newImage("assets/images/cursor.png")
constants.IMAGES_CURSOR_HAND_CLICKED       = love.graphics.newImage("assets/images/cursor_hand_clicked.png")
constants.IMAGES_CURSOR_HAND               = love.graphics.newImage("assets/images/cursor_hand.png")
constants.IMAGES_SAMPLE_WINDOW             = love.graphics.newImage("assets/images/sample_window.png")


-- yearbook images
constants.IMAGES_YB_AC               = love.graphics.newImage("assets/images/yearbook/yearbook_ac.png")
constants.IMAGES_YB_DF               = love.graphics.newImage("assets/images/yearbook/yearbook_df.png")
constants.IMAGES_YB_GI               = love.graphics.newImage("assets/images/yearbook/yearbook_gi.png")
constants.IMAGES_YB_JM               = love.graphics.newImage("assets/images/yearbook/yearbook_jm.png")
constants.IMAGES_YB_NP               = love.graphics.newImage("assets/images/yearbook/yearbook_np.png")
constants.IMAGES_YB_QS               = love.graphics.newImage("assets/images/yearbook/yearbook_qs.png")
constants.IMAGES_YB_TV               = love.graphics.newImage("assets/images/yearbook/yearbook_tv.png")
constants.IMAGES_YB_WZ               = love.graphics.newImage("assets/images/yearbook/yearbook_wz.png")
constants.IMAGES_YB_ARROWS_NONE      = love.graphics.newImage("assets/images/yearbook/yearbook_arrow_none.png")
constants.IMAGES_YB_ARROWS_LEFT      = love.graphics.newImage("assets/images/yearbook/yearbook_arrow_left.png")
constants.IMAGES_YB_ARROWS_RIGHT     = love.graphics.newImage("assets/images/yearbook/yearbook_arrow_right.png")
constants.IMAGES_YB_STUDENT_CARD_BG  = love.graphics.newImage("assets/images/yearbook/yearbook_studentcard.png")

-- sounds
constants.SOUNDS_MOUSE_CLICK = love.audio.newSource("assets/sounds/click.mp3", "static")
constants.SOUNDS_PAGE_TURN = love.audio.newSource("assets/sounds/pages.mp3", "static")

-- scenes
constants.SCENES_DESKTOP  = "desktop"
constants.SCENES_CALENDAR = "calendar"
constants.SCENES_COMPUTER = "computer"
constants.SCENES_YEARBOOK = "yearbook"
constants.SCENES_COURSES  = "courses"
constants.SCENES_AGENDA   = "agenda"
constants.SCENES_TITLE    = "title"
constants.SCENES_YEARBOOK = "yearBook"
constants.SCENES_YEARBOOK_STUDENT_CARD = "yearBookStudentCard"

-- keys
constants.KEYS_PAUSE_MENU  = "p"
constants.KEYS_ESCAPE_MENU = "escape"

-- various
constants.MOUSE_SIZE          = 64
constants.DEFAULT_CURSOR      = "default"
constants.HAND_CURSOR         = "hand"
constants.HAND_CLICKED_CURSOR = "hand_clicked"
constants.DAYS_IN_MONTH = {               --numero di giorni per ogni mese
    [1] = 31,  -- January
    [2] = 28,  -- February
    [3] = 31,  -- March
    [4] = 30,  -- April
    [5] = 31,  -- May
    [6] = 30,  -- June
    [7] = 31,  -- July
    [8] = 31,  -- August
    [9] = 30,  -- September
    [10] = 31, -- October
    [11] = 30, -- November
    [12] = 31  -- December
}


-- Tabella con le attività schedulate
constants.repeatedActivity={
  cooking =       {1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1},
  rock_climbing = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1},
  gaming_night =  {1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1},
  gym =           {1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0},
  jogging =       {0,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,1,1},
  go_kart =       {0,0,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1,1,1,1,1,0,1,1}
}

-- Tabella con le attività ripetute
constants.scheduledActivity = {
  soccer =        {0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, -- Solo il primo giorno occupato
  basket =        {1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, -- Secondo giorno occupato
  golf =          {1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  PartyHard =     {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1}, -- Solo il 27° giorno
  swimming =      {1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}, -- Solo il 4° giorno
  chess =         {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1} -- Solo il 21° giorno
}

return constants
