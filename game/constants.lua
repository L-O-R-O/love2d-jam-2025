local constants = {}

-- fonts
constants.FONTS_NICE_CHALK_TITLE = love.graphics.newFont("assets/font/NiceChalk.ttf",32)
constants.FONTS_NICE_CHALK_BODY  = love.graphics.newFont("assets/font/NiceChalk.ttf",18)
constants.FONTS_MAIN_MENU        = love.graphics.newFont("assets/font/NiceChalk.ttf", 50)
constants.FONTS_SUB_MENU         = love.graphics.newFont("assets/font/NiceChalk.ttf", 40)
constants.FONTS_ROBOTO           = love.graphics.newFont("assets/font/Roboto-Black.ttf", 20)
constants.FONTS_NICE_CHALK       = love.graphics.newFont("assets/font/NiceChalk.ttf", 20)
constants.FONTS_CALENDAR_MONTH   = love.graphics.newFont("assets/font/NiceChalk.ttf", 70)

-- images
constants.IMAGES_HOVER_DESKTOP_COMPUTER    = love.graphics.newImage("assets/images/hover_desktop_pc.png")
constants.IMAGES_HOVER_DESKTOP_CALENDAR    = love.graphics.newImage("assets/images/hover_desktop_calendario.png")
constants.IMAGES_HOVER_DESKTOP_AGENDA      = love.graphics.newImage("assets/images/hover_desktop_agenda.png")
constants.IMAGES_DESKTOP_BG                = love.graphics.newImage("assets/images/desktop.png")
constants.IMAGES_CALENDAR_BG               = love.graphics.newImage("assets/images/zoom/zoom_calendar.png")
constants.IMAGES_CURSOR                    = love.graphics.newImage("assets/images/cursor.png")
constants.IMAGES_CURSOR_HAND_CLICKED       = love.graphics.newImage("assets/images/cursor_hand_clicked.png")
constants.IMAGES_CURSOR_HAND               = love.graphics.newImage("assets/images/cursor_hand.png")
constants.IMAGES_SAMPLE_WINDOW             = love.graphics.newImage("assets/images/sample_window.png")
constants.IMAGES_CALENDAR_RED_CIRCLE       = love.graphics.newImage("assets/images/red_circle.png")
constants.IMAGES_AGENDA_BG_FULL            = love.graphics.newImage("assets/images/zoom/zoom_journal1.png")
constants.IMAGES_AGENDA_BG_STRIKE_1        = love.graphics.newImage("assets/images/zoom/zoom_journal2.png")
constants.IMAGES_AGENDA_BG_STRIKE_2        = love.graphics.newImage("assets/images/zoom/zoom_journal3.png")
constants.IMAGES_HEART                     = love.graphics.newImage("assets/images/heart_placeholder.png")

-- yearbook images
constants.IMAGES_YB_AC = love.graphics.newImage("assets/images/yearbook/yearbook_ac.png")
constants.IMAGES_YB_DF = love.graphics.newImage("assets/images/yearbook/yearbook_df.png")
constants.IMAGES_YB_GI = love.graphics.newImage("assets/images/yearbook/yearbook_gi.png")
constants.IMAGES_YB_JM = love.graphics.newImage("assets/images/yearbook/yearbook_jm.png")
constants.IMAGES_YB_NP = love.graphics.newImage("assets/images/yearbook/yearbook_np.png")
constants.IMAGES_YB_QS = love.graphics.newImage("assets/images/yearbook/yearbook_qs.png")
constants.IMAGES_YB_TV = love.graphics.newImage("assets/images/yearbook/yearbook_tv.png")
constants.IMAGES_YB_WZ = love.graphics.newImage("assets/images/yearbook/yearbook_wz.png")
constants.IMAGES_YB_ARROWS_NONE = love.graphics.newImage("assets/images/yearbook/yearbook_arrow_none.png")
constants.IMAGES_YB_ARROWS_LEFT = love.graphics.newImage("assets/images/yearbook/yearbook_arrow_left.png")
constants.IMAGES_YB_ARROWS_RIGHT = love.graphics.newImage("assets/images/yearbook/yearbook_arrow_right.png")
constants.IMAGES_YB_STUDENT_CARD_BG = love.graphics.newImage("assets/images/yearbook/yearbook_studentcard.png")

-- courses/activities images
constants.IMAGES_CS_BG               = love.graphics.newImage("assets/images/activities/activities.png")
constants.IMAGES_CS_ARROWS_NONE      = love.graphics.newImage("assets/images/activities/activities_arrow_none.png")
constants.IMAGES_CS_ARROWS_LEFT      = love.graphics.newImage("assets/images/activities/activities_arrow_left.png")
constants.IMAGES_CS_ARROWS_RIGHT     = love.graphics.newImage("assets/images/activities/activities_arrow_right.png")
constants.IMAGES_CS_ACTIVITY_CARD_BG = love.graphics.newImage("assets/images/activities/activities_info.png")

-- sounds
constants.SOUNDS_MOUSE_CLICK        = love.audio.newSource("assets/sounds/click.mp3", "static")
constants.SOUNDS_PAGE_TURN          = love.audio.newSource("assets/sounds/pages.mp3", "static")
constants.SOUNDS_BACKGROUND_MUSIC   = love.audio.newSource("assets/sounds/theme.mp3", "stream")
--constants.SOUNDS_BACKGROUND_AMBIENT = love.audio.newSource("assets/sounds/ambient.mp3", "stream")

-- scenes
constants.SCENES_DESKTOP = "desktop"
constants.SCENES_CALENDAR = "calendar"
constants.SCENES_COMPUTER = "computer"
constants.SCENES_YEARBOOK = "yearbook"
constants.SCENES_COURSES = "courses"
constants.SCENES_AGENDA = "agenda"
constants.SCENES_TITLE = "title"
constants.SCENES_YEARBOOK = "yearBook"
constants.SCENES_YEARBOOK_STUDENT_CARD  = "yearBookStudentCard"
constants.SCENES_COURSES_ACTIVITY_CARD  = "coursesActivityCard"
constants.SCENES_CONFIRM = "confirm"
constants.SCENES_OUTCOME = "outcome"
constants.SCENES_OUTCOME = "outcome"
constants.SCENES_GAME_OVER = "gameOver"

-- keys
constants.KEYS_PAUSE_MENU = "p"
constants.KEYS_ESCAPE_MENU = "escape"

-- various
constants.GAME_MANAGER_MAX_PLAYABLE = 10
constants.MAX_STRIKES = 3
constants.MOUSE_SIZE = 64
constants.DEFAULT_CURSOR = "default"
constants.HAND_CURSOR = "hand"
constants.HAND_CLICKED_CURSOR = "hand_clicked"
constants.DAYS_IN_MONTH = { --numero di giorni per ogni mese
  [1] = 31, -- January
  [2] = 28, -- February
  [3] = 31, -- March
  [4] = 30, -- April
  [5] = 31, -- May
  [6] = 30, -- June
  [7] = 31, -- July
  [8] = 31, -- August
  [9] = 30, -- September
  [10] = 31, -- October
  [11] = 30, -- November
  [12] = 31, -- December
}
constants.MONTH_NAMES = {
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
}

constants.WEEK_DAYS = {
  [1] = "Monday",
  [2] = "Tuesday",
  [3] = "Wednesday",
  [4] = "Thursday",
  [5] = "Friday",
  [6] = "Saturday",
  [7] = "Sunday",
}

-- Tabella con le attività schedulate
constants.repeatedActivity = {
  cooking = { 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1 },
  rock_climbing = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1 },
  gaming_night = { 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1 },
  gym = { 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0 },
  jogging = { 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1 },
  go_kart = { 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1 },
}

-- Tabella con le attività ripetute
constants.scheduledActivity = {
  soccer = { 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
  basket = { 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
  golf = { 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
  PartyHard = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1 },
  swimming = { 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
  chess = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
}

constants.OUTCOMESTATE = {
  'Session Win',
  'Session KO',
  'Game Win',
  'Game KO'
}

constants.ACTIVITIES = {
  {name = "Botanic Battle Royale",      description = "Participants create mini botanical gardens in small containers. The most original or aesthetically pleasing ecosystem wins."},
  {name = "Deep Dive Movie Quiz",       description = "A cinematic quiz inspired by the iceberg theory, where participants earn points by uncovering hidden details in films."},
  {name = "Boxing Beatdown Relay",      description = "A team competition combining boxing sessions on punching bags with cheerleading choreography to celebrate each round won."},
  {name = "Cross-Stitch & Mosh Pit",    description = "A unique event where participants cross-stitch to heavy metal music. The most punk and detailed creations win!"},
  {name = "Taxidermy Tales Theater",    description = "Participants use taxidermy animals (or plushies for a lighter approach) to perform improvised theatrical plays."},
  {name = "Custom Tee Skate Showdown",  description = "Participants design and print custom t-shirts, then show them off during a mini skateboarding contest."},
  {name = "Chessfold Championship",     description = "A tournament alternating between chess matches and creative origami challenges, where winning pieces are folded into art."},
  {name = "Home Fix Olympics",          description = "A competition featuring challenges like sewing buttons, fixing broken items, or assembling shelves in record time."},
  {name = "Rugby Rodeo",                description = "A mix of rugby and physical skill games, including obstacle courses and endurance challenges with rugby balls."},
  {name = "Flex & Freeze Dance-Off",    description = "A competition combining flexing poses with dance moves, rewarding smooth transitions between strength and rhythm."}
}

constants.STUDENTS = {
  {
    nickname = "Green Thumb",
    name = "Beatrice Blossom",
    image = "assets/images/students/BEATRICE.PNG",
    quote = "Sing like no one is listening, love like you've never been hurt, dance like no one is watching, and live like it is heaven on earth.",
    futurePlans = "Become an environmental lawyer to take down evil corporations one lawsuit at a time — all while wearing ethically sourced cardigans.",
    bestMemory = "Freeing the lab monkeys before spring break. (Still not sure if that was legal. Probably wasn't.)",
    favoriteDnDClass = "Druid — because nature deserves better.",
    inGuild = false,
  },
  {
    nickname = "Edgelord",
    name = "Edward Thompson",
    image = love.graphics.newImage("assets/images/students/EDWARD.PNG"),
    quote = "I am so clever that sometimes I don't understand a single word of what I am saying.",
    futurePlans = "Becoming a famous indie filmmaker (but only for the kind of films where the main character stares into the rain dramatically).",
    bestMemory = "Kicking soda cans around the mall parking lot like it was an Olympic sport.",
    favoriteDnDClass = "Rogue — because blending into the shadows is a lifestyle.",
    inGuild = false,
  },
  {
    nickname = "World Domination",
    name = "Jessica Newton",
    image = "assets/images/students/JESSICA.PNG",
    quote = "It is better to be hated for what you are than to be loved for what you are not.",
    futurePlans = "First female President of the United States.",
    bestMemory = "Friday night pajama parties with the besties.",
    favoriteDnDClass = "Barbarian — because taking charge and breaking things aren't mutually exclusive.",
    inGuild = false,
  },
  {
    nickname = "The Metal Queen",
    name = "Ginevra Arenton",
    image = "assets/images/students/ginevra_arenton.png",
    quote = "Without music, life would be a mistake.",
    futurePlans = "Becoming the next rock sensation, ideally headlining a festival where people throw underwear on stage.",
    bestMemory = "That sick 10-minute guitar solo at Battle of the Bands (the judges are still talking about it).",
    favoriteDnDClass = "Bard — because what's life without a little flair?",
    inGuild = false,
  },
  {
    nickname = "Living Dead Girl",
    name = "Zoe Barry",
    image = "assets/images/students/zoe_barry.png",
    quote = "Always forgive your enemies; nothing annoys them so much.",
    futurePlans = "Open her own tattoo parlor — a cool one, where the playlist is nothing but industrial metal and sad boy punk.",
    bestMemory = "Winning first prize at the regional art contest. Her painting of a flaming raven was truly one of a kind.",
    favoriteDnDClass = "Warlock — because power is cooler when it's a little forbidden.",
    inGuild = false,
  },
  {
    nickname = "Turbo",
    name = "Max Reynolds",
    image = "assets/images/students/MAX.PNG",
    quote = "If you're not first, you're last.",
    futurePlans = "Becoming a professional skateboarder, or maybe just a guy who skates a lot.",
    bestMemory = "That one time I ollied over Principal Harris' flower bed and didn't get detention (he definitely saw me).",
    favoriteDnDClass = "Monk — fast, unpredictable, and occasionally faceplants.",
    inGuild = false,
  },
  {
    nickname = "The Brain",
    name = "Olivia Park",
    image = "assets/images/students/OLIVIA.PNG",
    quote = "I have not failed. I've just found 10,000 ways that won't work.",
    futurePlans = "Become a scientist, discover something cool, and get a building named after her.",
    bestMemory = "Correcting Mr. Johnson's math on the whiteboard and getting extra credit for it (he still hasn't forgiven me).",
    favoriteDnDClass = "Wizard — because knowledge is power (and fireballs).",
    inGuild = false,
  },
  {
    nickname = "Gearhead",
    name = "Riley Thompson",
    image = "assets/images/students/RILEY.PNG",
    quote = "The best way to predict the future is to invent it.",
    futurePlans = "Build a robot butler and retire early.",
    bestMemory = "When my science fair project accidentally set off the fire alarm (I still won).",
    favoriteDnDClass = "Artificer — because who needs magic when you have engineering?",
    inGuild = false,
  },
  {
    nickname = "Shield Maiden",
    name = "Florence Hale",
    image = "assets/images/students/FLORENCE.PNG",
    quote = "No one can make you feel inferior without your consent.",
    futurePlans = "Join the military, become a firefighter, or maybe run a charity.",
    bestMemory = "Standing up to a teacher who embarrassed a classmate — and getting half the class to walk out with her.",
    favoriteDnDClass = "Paladin — because someone has to protect the kingdom. Well, I mean, the student council.",
    inGuild = false,
  },
  {
    nickname = "Iron Fist",
    name = "Marcus Lee",
    image = "assets/images/students/MARCUS.PNG",
    quote = "Pain is weakness leaving the body.",
    futurePlans = "Become a personal trainer, then maybe a superhero if that's still an option.",
    bestMemory = "Bench pressing more than Coach Davis and getting a high-five for it.",
    favoriteDnDClass = "Fighter — hit hard, ask questions later.",
    inGuild = false,
  },
  {
    nickname = "The Human Bulldozer",
    name = "Taylor  Johnson",
    image = "",
    quote = "You can be a warrior and a cinnamon roll too.",
    futurePlans = "Professional wrestler or preschool teacher — honestly, whichever hires first.",
    bestMemory = "Winning the senior tug-of-war while casually eating a granola bar mid-pull.",
    favoriteDnDClass = "Barbarian — because sometimes love looks like a bear hug (with possible rib injuries).",
    inGuild = false,
  },
  {
    nickname = "The Wildfire",
    name = "Ava Hayes",
    image = "",
    quote = "Normal is an illusion. What is normal for the spider is chaos for the fly.",
    futurePlans = 'Still deciding between "becoming a celebrity" or "accidentally becoming a celebrity."',
    bestMemory = 'That time I convinced half the school spirit squad to dye their hair neon green for "prank week."',
    favoriteDnDClass = "Sorcerer — born with magic and vibes alone.",
    inGuild = false,
  },
  {
    nickname = "The Healer",
    name = "Charlie Brooks",
    image = "",
    quote = "Be kind whenever possible. It is always possible.",
    futurePlans = "Become a nurse or a therapist.",
    bestMemory = "Talking Jake down from fighting the vending machine after it stole his dollar.",
    favoriteDnDClass = "Paladin — because someone's gotta protect these disaster gremlins from themselves.",
    inGuild = false,
  },
  {
    nickname = "Trailblazer",
    name = "Logan Rivera",
    image = "assets/images/students/LOU.png",
    quote = "Not all those who wander are lost.",
    futurePlans = "Hiking the Appalachian Trail, then maybe figuring out what to do with life.",
    bestMemory = "Camping with friends and telling ghost stories until the fire went out.",
    favoriteDnDClass = "Ranger — prefers animals to people, honestly.",
    inGuild = false,
  },
  {
    nickname = "Headbanger",
    name = "Lou Vasquez",
    image = "assets/images/students/LOU.png",
    quote = "Turn it up to eleven.",
    futurePlans = "Touring with the band, breaking a few amps, and living loud.",
    bestMemory = "That first time on stage, feeling the roar of the crowd and the bass in my bones.",
    favoriteDnDClass = "Bard — but make it all distortion pedals and screaming solos.",
    inGuild = true
  },
  {
    name = "Abel Funkleton",
    bestMemory = "Collects mismatched socks",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Alberto Bananovich",
    bestMemory = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Anna Von Sprinkles",
    bestMemory = "Always carries a rubber duck",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Archibald Swooshtail",
    bestMemory = "Thinks lizards are cool",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Beatrice Wiggly",
    bestMemory = "Owns 50 pairs of sunglasses",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Bea Quokka",
    bestMemory = "Giggles uncontrollably at puns",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Bianca Thunderfoot",
    bestMemory = "Speaks in rhymes",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Bridget Twinklepaws",
    bestMemory = "Can identify trees by their leaves",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Cesare McQuack",
    bestMemory = "Has a collection of rubber ducks",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Cecil Whimsyfoot",
    bestMemory = "Loves cheesy romance novels",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Desdemona Wifflewhirl",
    bestMemory = "Writes secret notes to herself",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Dina Fizzlesnoot",
    bestMemory = "Owns 40 different scarves",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Domenico Twizzler",
    bestMemory = "Eats ice cream even in winter",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Elliott McMuffins",
    bestMemory = "Can hum two songs at once",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Emma Zoodle",
    bestMemory = "Can quote every line from her favorite movie",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Ephraim Snorkelstein",
    bestMemory = "Is really good at trivia",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Flora Snickerwhistle",
    bestMemory = "Talks to her plants",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Florentino Lollington",
    bestMemory = "Loves dad jokes",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Francesco O'Pajamas",
    bestMemory = "Wears pajamas all day",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Filippo Lollington",
    bestMemory = "Loves dad jokes",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Ginevra Popcorn",
    bestMemory = "Can recite the alphabet backwards",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Giorgio Snickerdoodle",
    bestMemory = "Invents weird conspiracy theories",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Gilbert Fizzlebop",
    bestMemory = "Has an entire closet dedicated to hats",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Harald Snickers",
    bestMemory = "Talks to houseplants",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Harriet Muffinwhisk",
    bestMemory = "Can balance a spoon on her nose",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Hana Stardancer",
    bestMemory = "Has a secret talent for juggling",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Ike Twinkleboots",
    bestMemory = "Laughs at his own jokes",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Ivy Gigglequack",
    bestMemory = "Loves roller coasters but hates heights",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Jacopo Pogo",
    bestMemory = "Can play any song on the kazoo",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Jasmine Flapdoodle",
    bestMemory = "Loves collecting postcards",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Klaus Bumblepants",
    bestMemory = "Can recite Shakespeare backwards",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Laura Thunderpants",
    bestMemory = "Afraid of butterflies",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Lena Taterbop",
    bestMemory = "Always carries at least three snacks",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Miles Quirkendorf",
    bestMemory = "Thinks pineapple belongs on pizza",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Mortimer Quackfoot",
    bestMemory = "Still believes in Santa",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Nellie Jumblebean",
    bestMemory = "Has a weird talent for balancing things",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Nina Doodleflop",
    bestMemory = "Invents her own words",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Olga Waffleton",
    bestMemory = "Has a pet turtle named Steve",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Olivier Fumbleton",
    bestMemory = "Only eats the crusts of sandwiches",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Oscar Muffinfeet",
    bestMemory = "Sleeps with socks on",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Oscar Wigglytoes",
    bestMemory = "Dances while brushing his teeth",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Penelope Soggytoes",
    bestMemory = "Afraid of butterflies",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Pietro Limoncello",
    bestMemory = "Can do an uncanny duck impression",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Quentin Swoosh",
    bestMemory = "Has never lost a staring contest",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Quincy Snorfblat",
    bestMemory = "Can wiggle his ears independently",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Renee Marshmellow",
    bestMemory = "Has a lucky coin",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Rosa Bloop",
    bestMemory = "Only drinks iced coffee",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Rosalie Tiddlybop",
    bestMemory = "Refuses to eat blue foods",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Sebastian Waddlequack",
    bestMemory = "Talks to himself in the mirror",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Silvio Quirk",
    bestMemory = "Can nap anywhere",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Tasha Flibberflop",
    bestMemory = "Speaks fluent pirate",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Teodoro Tumbleweed",
    bestMemory = "Has a lucky penny",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Ulrich Squigglefist",
    bestMemory = "Has a pet hamster named Pudding",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Valerie Gobblepants",
    bestMemory = "Eats breakfast for dinner",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Valerio Doodlepop",
    bestMemory = "Always carries a notebook",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Wendy Squish",
    bestMemory = "Loves horror movies but gets scared easily",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Xander Pudding",
    bestMemory = "Talks to himself in the mirror",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Yvonne Jigglybean",
    bestMemory = "Owns 200 pairs of socks",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Zaccaria Floop",
    bestMemory = "Doesn't like chocolate",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
  {
    name = "Zelda Bloopington",
    bestMemory = "Hiccups when nervous",
    image = nil,
    quote = nil,
    futurePlans = nil,
    favoriteDnDClass = nil,
    inGuild = false,
  },
}


function constants.setFont(font, size)
  return love.graphics.setFont(love.graphics.newFont("assets/font/" .. font .. ".ttf", size))
end

return constants
