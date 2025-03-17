local constants = {}

-- fonts
constants.MAIN_MENU_FONT = love.graphics.newFont("assets/font/Hello_Sweet_Rain.ttf", 30)
constants.SUB_MENU_FONT  = love.graphics.newFont("assets/font/Hello_Sweet_Rain.ttf", 20)

-- images
constants.IMAGES_DESKTOP_BG_HOVERED   = love.graphics.newImage("assets/images/desktop_hovered.png")
constants.IMAGES_DESKTOP_BG           = love.graphics.newImage("assets/images/desktop.png")
constants.IMAGES_COMPUTER_BG          = love.graphics.newImage("assets/images/provazoom_pc.png")
constants.IMAGES_CALENDAR_BG          = love.graphics.newImage("assets/images/prova_calendario.png")
constants.IMAGES_AGENDA_BG            = love.graphics.newImage("assets/images/provazoom_calendario.png")
constants.IMAGES_CURSOR               = love.graphics.newImage("assets/images/cursor.png")
constants.IMAGES_CURSOR_HAND_CLICKED  = love.graphics.newImage("assets/images/cursor_hand_clicked.png")
constants.IMAGES_CURSOR_HAND          = love.graphics.newImage("assets/images/cursor_hand.png")
constants.IMAGES_SAMPLE_WINDOW        = love.graphics.newImage("assets/images/sample_window.png")

-- sounds
constants.SOUNDS_MOUSE_CLICK = love.audio.newSource("assets/sounds/click.mp3", "static")
constants.SOUNDS_PAGE_TURN = love.audio.newSource("assets/sounds/pages.mp3", "static")

-- scenes
constants.SCENES_DESKTOP  = "desktop"
constants.SCENES_CALENDAR = "calendar"
constants.SCENES_COMPUTER = "computer"
constants.SCENES_AGENDA   = "agenda"
constants.SCENES_TITLE    = "title"

-- keys
constants.KEYS_PAUSE_MENU  = "p"
constants.KEYS_ESCAPE_MENU = "escape"

-- various
constants.MOUSE_SIZE          = 64
constants.DEFAULT_CURSOR      = "default"
constants.HAND_CURSOR         = "hand"
constants.HAND_CLICKED_CURSOR = "hand_clicked"


return constants
