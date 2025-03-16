local constants = {}

-- fonts
constants.MAIN_MENU_FONT = love.graphics.newFont("assets/font/Hello_Sweet_Rain.ttf", 30)
constants.SUB_MENU_FONT  = love.graphics.newFont("assets/font/Hello_Sweet_Rain.ttf", 20)

-- images
constants.IMAGES_DESKTOP_BG = love.graphics.newImage("assets/images/desktop.jpg")

-- scenes
constants.SCENES_DESKTOP  = "desktop"
constants.SCENES_CALENDAR = "calendar"
constants.SCENES_COMPUTER = "computer"
constants.SCENES_AGENDA   = "agenda"
constants.SCENES_TITLE    = "title"

-- keys
constants.KEYS_PAUSE_MENU  = "p"
constants.KEYS_ESCAPE_MENU = "escape"

return constants
