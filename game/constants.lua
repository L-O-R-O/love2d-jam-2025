local constants = {}

-- fonts
constants.FONTS_NICE_CHALK_TITLE = love.graphics.newFont("assets/font/NiceChalk.ttf",32)
constants.FONTS_NICE_CHALK_BODY  = love.graphics.newFont("assets/font/NiceChalk.ttf",18)
constants.FONTS_NICE_CHALK_SMALL = love.graphics.newFont("assets/font/NiceChalk.ttf",15)
constants.FONTS_MAIN_MENU        = love.graphics.newFont("assets/font/NiceChalk.ttf", 50)
constants.FONTS_SUB_MENU         = love.graphics.newFont("assets/font/NiceChalk.ttf", 40)
constants.FONTS_CREDITS_MENU     = love.graphics.newFont("assets/font/NiceChalk.ttf", 25)
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
constants.IMAGES_HEART                     = love.graphics.newImage("assets/images/LIVES_FULL.png")
constants.IMAGES_HEART_STRIKE                     = love.graphics.newImage("assets/images/LIVES_STRIKE.png")
constants.IMAGES_MENU_BG                   = love.graphics.newImage("assets/images/menu_start.png")
constants.IMAGES_MENU_PAUSE_BG             = love.graphics.newImage("assets/images/menu_pause.png")


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

-- general ui images
constants.IMAGES_UI_BACK       = love.graphics.newImage("assets/images/ui/BACK.png")
constants.IMAGES_UI_BACK_HOVER = love.graphics.newImage("assets/images/ui/BACK_HOVER.png")
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
constants.MAX_HEARTS = 3
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

constants.OUTCOMESTATE = {
  'Session Win',
  'Session KO',
  'Game Win',
  'Game KO'
}

constants.ACTIVITIES = {
  {name = "Botanic Battle Royale",       description = "Participants create mini botanical gardens in small containers. The most original or aesthetically pleasing ecosystem wins."},
  {name = "Deep Dive Movie Quiz",        description = "A cinematic quiz inspired by the iceberg theory, where participants earn points by uncovering hidden details in films."},
  {name = "Boxing Beatdown Relay",       description = "A team competition combining boxing sessions on punching bags with cheerleading choreography to celebrate each round won."},
  {name = "Cross-Stitch & Mosh Pit",     description = "A unique event where participants cross-stitch to heavy metal music. The most punk and detailed creations win!"},
  {name = "Taxidermy Tales Theater",     description = "Participants use taxidermy animals (or plushies for a lighter approach) to perform improvised theatrical plays."},
  {name = "Custom Tee Skate Showdown",   description = "Participants design and print custom t-shirts, then show them off during a mini skateboarding contest."},
  {name = "Chessfold Championship",      description = "A tournament alternating between chess matches and creative origami challenges, where winning pieces are folded into art."},
  {name = "Home Fix Olympics",           description = "A competition featuring challenges like sewing buttons, fixing broken items, or assembling shelves in record time."},
  {name = "Rugby Rodeo",                 description = "A mix of rugby and physical skill games, including obstacle courses and endurance challenges with rugby balls."},
  {name = "Flex & Freeze Dance-Off",     description = "A competition combining flexing poses with dance moves, rewarding smooth transitions between strength and rhythm."},
  {name = "Graffiti Gauntlet",           description = "Participants navigate an obstacle course while creating a collaborative graffiti mural along the way."},
  {name = "Blindfolded Bake-Off",        description = "Teams must bake a dessert while blindfolded, guided only by verbal instructions from their partners."},
  {name = "Echo Chamber Karaoke",        description = "A singing contest where performers wear noise-canceling headphones and can’t hear their own voices."},
  {name = "DIY Cosplay Combat",          description = "Participants create quick cosplay outfits from random materials and then compete in themed duels."},
  {name = "Synchronized Scooter Ballet", description = "A team event blending scooter tricks with synchronized choreography for the most artistic performance."},
  {name = "Speedrun Scrap Sculptures",   description = "Teams build sculptures using only scrap materials within a limited time. The most creative structure wins."},
  {name = "Horror Haiku Slam",           description = "A poetry contest where participants craft and perform eerie haikus in a dramatic setting."},
  {name = "Gravity-Defying Jenga",       description = "A Jenga challenge on moving platforms, requiring balance and precision to avoid toppling the tower."},
  {name = "Parkour Paint Tag",           description = "A game of tag where participants leave colorful paint marks on obstacles as they traverse a parkour course."},
  {name = "Reverse Engineering Riddle",  description = "Teams receive a finished product and must deduce its original assembly process to reconstruct it correctly."},
  {name = "Battle of the Bubble Wrap",   description = "Contestants wear bubble wrap armor and engage in playful duels to see who can stay unpopped the longest."},
  {name = "Acapella Air Guitar Showdown",description = "A competition where participants perform epic air guitar solos accompanied only by their own vocal sound effects."},
  {name = "Subway Sketch-Off",           description = "Artists must quickly sketch strangers on public transport without being noticed."},
  {name = "Steampunk Soapbox Speeches",  description = "Participants deliver impassioned speeches on wild, fictional topics while dressed in full steampunk attire."},
  {name = "Lava Floor Dodgeball",        description = "A dodgeball game where players must avoid the ball while staying on elevated platforms, pretending the floor is lava."},
  {name = "Silent Rave Capture the Flag",description = "A capture-the-flag game played at a silent disco, where teams communicate only through dance moves."},
  {name = "Tattoo Tarot",                description = "Participants design temporary tattoos inspired by randomly drawn tarot cards."},
  {name = "Neon Ninja Obstacle Course",  description = "A night-time obstacle course where players navigate glowing challenges while dressed in blacklight-reactive gear."},
  {name = "Shakespearean Rap Battle",    description = "A rap battle where lyrics must be in Shakespearean language and delivered in iambic pentameter."},
  {name = "Spaghetti Suspension Bridge", description = "Teams construct bridges out of spaghetti and test their strength by placing weights on them."},
  {name = "Extreme Origami Fencing",     description = "Contestants must fold paper into swords and duel until their opponent’s weapon crumbles."},
  {name = "Quantum Charades",            description = "A game of charades where every action must have two possible meanings at once, forcing creative guesses."},
  {name = "Beatboxing Bee",              description = "A spelling bee where contestants must beatbox their way through the pronunciation of difficult words."},
  {name = "Escape Room Speedrun",        description = "Teams attempt to break out of an escape room in record time with minimal clues."},
  {name = "Reverse Pictionary",          description = "Artists blindly draw a picture based only on their partner’s reaction to each stroke."},
  {name = "Marathon Monopoly",           description = "A Monopoly tournament where each roll of the dice requires completing a physical endurance challenge."},
  {name = "Tech-Free Treasure Hunt",     description = "A scavenger hunt where participants must navigate using only analog tools like paper maps and compasses."},
  {name = "Synchronized Slacklining",    description = "Teams perform synchronized routines on slacklines, blending balance with acrobatics."},
  {name = "Cyberpunk Costume Dash",      description = "Contestants create cyberpunk outfits from thrifted or found materials in under an hour."},
  {name = "Firefly Glowstick Chase",     description = "A night game where players act as 'fireflies,' using glowsticks to lead their team through a darkened course."},
  {name = "No-Handed Pottery Duel",      description = "A pottery-making challenge where participants must sculpt using only their elbows or feet."},
  {name = "Time Traveler’s Debate",      description = "A debate game where each participant argues from the perspective of a different historical or futuristic era."},
  {name = "Viking Feast Mystery Cookoff",description = "A cooking competition where teams must prepare a dish using only ingredients available in Viking times."},
  {name = "Bubble Tea Pong",             description = "A twist on beer pong where cups are filled with bubble tea, and players must drink the boba before shooting again."},
  {name = "Giant Shadow Puppetry",       description = "Teams use oversized cutouts and projectors to create elaborate shadow puppet performances."},
  {name = "Cardboard Combat League",     description = "Participants craft weapons and armor from cardboard and engage in strategic duels."},
  {name = "Retro Arcade Remix",          description = "A competition where players must beat classic arcade games using unconventional controllers."},
  {name = "Silent Library Stunt Show",   description = "A challenge where contestants must perform extreme stunts or hilarious dares without making a sound in a real library."},
  {name = "Underwater Charades",         description = "A classic game of charades, but played entirely underwater for an extra challenge."},
  {name = "Shadowboxing Storytime",      description = "Participants narrate a story while performing a shadowboxing routine. The best combination of storytelling and movement wins!"},
  {name = "Invisible Maze Relay",        description = "Players must navigate an invisible maze relying only on verbal instructions from their team."},
  {name = "Flash Mob Freeze Tag",        description = "A game of tag where players must freeze in dramatic poses when touched."},
  {name = "Origami Speed Challenge",     description = "Contestants race to fold as many perfect origami figures as possible within a time limit."},
  {name = "Backwards Olympics",          description = "A series of sports challenges that must be performed entirely in reverse."},
  {name = "Duct Tape Fashion Show",      description = "A fashion contest where outfits are made exclusively from duct tape."},
  {name = "Bubble Wrap Ballet",          description = "A dance performance where participants must move elegantly without popping bubble wrap on the floor."},
  {name = "Lightning Round LARP",        description = "A live-action role-playing game where the scenario changes every five minutes."},
  {name = "One-Handed Puzzle Race",      description = "A puzzle-solving race where players can only use one hand."},
  {name = "Mirror Dance Battle",         description = "A dance-off where pairs must mimic each other’s moves like a mirror."},
  {name = "Glow-in-the-Dark Capture the Flag", description = "A nighttime version of capture the flag with glowing flags and markers."},
  {name = "Cardboard Box Grand Prix",    description = "A race where participants must build and ride vehicles made entirely from cardboard."},
  {name = "Improv Sci-Fi Dub",           description = "Players must live-dub silent scenes from old sci-fi films with improvised dialogue."},
  {name = "Giant Puzzle Heist",          description = "Teams race to retrieve scattered puzzle pieces and complete the puzzle first."},
  {name = "Musical Chairs Obstacle Course", description = "A chaotic version of musical chairs with obstacles between each seat."},
  {name = "Speedrun Stop Motion",        description = "Teams must create a stop-motion animation in the shortest possible time."},
  {name = "Alien Language Spelling Bee", description = "A spelling bee where contestants must spell words in invented alien languages."},
  {name = "Emoji Pictionary",            description = "A Pictionary game where words are replaced with emoji sequences."},
  {name = "Jellybean Architecture",      description = "Contestants construct creative structures using only jellybeans and toothpicks."},
  {name = "Silent Movie Lip Sync",       description = "Players must lip-sync and act out silent movie scenes with exaggerated gestures."},
  {name = "Theatrical Rock-Paper-Scissors", description = "A dramatic take on rock-paper-scissors where each move is performed as a theatrical act."},
  {name = "Zero Gravity Yoga",           description = "A yoga challenge where participants must move as if in zero gravity."},
  {name = "Wind Tunnel Dodgeball",       description = "Dodgeball played in an area with strong fans that alter the ball’s trajectory."},
  {name = "Haunted Puppet Show",         description = "Teams create eerie puppet shows with improvised horror stories."},
  {name = "Giant Chess Parkour",         description = "A game of giant chess where players must complete parkour challenges to move pieces."}
}

constants.STUDENTS = {
  {
    nickname = "Green Thumb",
    name = "Beatrice Blossom",
    image = love.graphics.newImage("assets/images/students/CHARACTER_BEATRICE.png"),
    quote = "Sing like no one is listening, love like you've never been hurt, dance like no one is watching, and live like it is heaven on earth.",
    futurePlans = "Become an environmental lawyer to take down evil corporations one lawsuit at a time — all while wearing ethically sourced cardigans.",
    bestMemory = "Freeing the lab monkeys before spring break. (Still not sure if that was legal. Probably wasn't.)",
    favoriteDnDClass = "Druid — because nature deserves better.",
    inGuild = false,
  },
  {
    nickname = "Edgelord",
    name = "Edward Thompson",
    image = love.graphics.newImage("assets/images/students/CHARACTER_EDWARD.png"),
    quote = "I am so clever that sometimes I don't understand a single word of what I am saying.",
    futurePlans = "Becoming a famous indie filmmaker (but only for the kind of films where the main character stares into the rain dramatically).",
    bestMemory = "Kicking soda cans around the mall parking lot like it was an Olympic sport.",
    favoriteDnDClass = "Rogue — because blending into the shadows is a lifestyle.",
    inGuild = false,
  },
  {
    nickname = "World Domination",
    name = "Jessica Newton",
    image = love.graphics.newImage("assets/images/students/CHARACTER_JESSICA.png"),
    quote = "It is better to be hated for what you are than to be loved for what you are not.",
    futurePlans = "First female President of the United States.",
    bestMemory = "Friday night pajama parties with the besties.",
    favoriteDnDClass = "Barbarian — because taking charge and breaking things aren't mutually exclusive.",
    inGuild = false,
  },
  {
    nickname = "The Headbanger",
    name = "Lou Arenton",
    image = love.graphics.newImage("assets/images/students/CHARACTER_LOU.png"),
    quote = "Without music, life would be a mistake.",
    futurePlans = "Becoming the next rock sensation, ideally headlining a festival where people throw underwear on stage.",
    bestMemory = "That sick 10-minute guitar solo at Battle of the Bands (the judges are still talking about it).",
    favoriteDnDClass = "Bard — because what's life without a little flair?",
    inGuild = false,
  },
  {
    nickname = "Living Dead Girl",
    name = "Zoe Barry",
    image = "",
    quote = "Always forgive your enemies; nothing annoys them so much.",
    futurePlans = "Open her own tattoo parlor — a cool one, where the playlist is nothing but industrial metal and sad boy punk.",
    bestMemory = "Winning first prize at the regional art contest. Her painting of a flaming raven was truly one of a kind.",
    favoriteDnDClass = "Warlock — because power is cooler when it's a little forbidden.",
    inGuild = false,
  },
  {
    nickname = "Turbo",
    name = "Max Reynolds",
    image = love.graphics.newImage("assets/images/students/CHARACTER_MAX.png"),
    quote = "If you're not first, you're last.",
    futurePlans = "Becoming a professional skateboarder, or maybe just a guy who skates a lot.",
    bestMemory = "That one time I ollied over Principal Harris' flower bed and didn't get detention (he definitely saw me).",
    favoriteDnDClass = "Monk — fast, unpredictable, and occasionally faceplants.",
    inGuild = false,
  },
  {
    nickname = "The Brain",
    name = "Olivia Park",
    image = love.graphics.newImage("assets/images/students/CHARACTER_OLIVIA.png"),
    quote = "I have not failed. I've just found 10,000 ways that won't work.",
    futurePlans = "Become a scientist, discover something cool, and get a building named after her.",
    bestMemory = "Correcting Mr. Johnson's math on the whiteboard and getting extra credit for it (he still hasn't forgiven me).",
    favoriteDnDClass = "Wizard — because knowledge is power (and fireballs).",
    inGuild = false,
  },
  {
    nickname = "Gearhead",
    name = "Riley Thompson",
    image = love.graphics.newImage("assets/images/students/CHARACTER_RILEY.png"),
    quote = "The best way to predict the future is to invent it.",
    futurePlans = "Build a robot butler and retire early.",
    bestMemory = "When my science fair project accidentally set off the fire alarm (I still won).",
    favoriteDnDClass = "Artificer — because who needs magic when you have engineering?",
    inGuild = false,
  },
  {
    nickname = "Shield Maiden",
    name = "Florence Hale",
    image = love.graphics.newImage("assets/images/students/CHARACTER_FLORENCE.png"),
    quote = "No one can make you feel inferior without your consent.",
    futurePlans = "Join the military, become a firefighter, or maybe run a charity.",
    bestMemory = "Standing up to a teacher who embarrassed a classmate and getting half the class to walk out with her.",
    favoriteDnDClass = "Paladin — because someone has to protect the kingdom. Well, I mean, the student council.",
    inGuild = false,
  },
  {
    nickname = "Iron Fist",
    name = "Marcus Lee",
    image = love.graphics.newImage("assets/images/students/CHARACTER_MARCUS.png"),
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
    image = "",
    quote = "Not all those who wander are lost.",
    futurePlans = "Hiking the Appalachian Trail, then maybe figuring out what to do with life.",
    bestMemory = "Camping with friends and telling ghost stories until the fire went out.",
    favoriteDnDClass = "Ranger — prefers animals to people, honestly.",
    inGuild = false,
  },
  {
    name = "Abel Funkleton",
    bestMemory = "The time I won a race by wearing mismatched socks and distracting everyone with my dance moves.",
    image = nil,
    quote = "Sometimes, the greatest adventures are in the smallest things.",
    futurePlans = "Dreaming of one day opening a sock shop on the moon.",
    favoriteDnDClass = "Barbarian — I like to charge in headfirst.",
    inGuild = false,
  },
  {
    name = "Alberto Bananovich",
    bestMemory = "That summer I spent at a dance camp in Madrid. Learned most of my moves there!",
    image = nil,
    quote = "Bom, sha-sha ka-kà!",
    futurePlans = "Being a coreographer for many italian singers.",
    favoriteDnDClass = "Rogue - he's all for acrobatics",
    inGuild = false
  },
  {
    name = "Anna Von Sprinkles",
    bestMemory = "Remembers the time she accidentally won a rubber duck race at the fair",
    image = nil,
    quote = "Sometimes the smallest things take up the most room in your heart.",
    futurePlans = "Wants to open a rubber duck themed café",
    favoriteDnDClass = "Sorcerer",
    inGuild = false,
  },
  {
    name = "Archibald Swooshtail",
    bestMemory = "Once helped a lizard escape a hunter, and they’ve been friends ever since",
    image = nil,
    quote = "In every reptile, there's a little piece of wisdom.",
    futurePlans = "Plans to start a lizard sanctuary",
    favoriteDnDClass = "Druid",
    inGuild = false,
  },
  {
    name = "Beatrice Wiggly",
    bestMemory = "Got stuck in a hat shop for three hours because she couldn’t decide on the perfect pair of sunglasses",
    image = nil,
    quote = "Life’s too short to not wear fun sunglasses.",
    futurePlans = "Wants to become a personal shopper for sunglasses",
    favoriteDnDClass = "Rogue",
    inGuild = false,
  },
  {
    name = "Bea Quokka",
    bestMemory = "Laughed so hard at a pun contest that she snorted milk out of her nose",
    image = nil,
    quote = "A pun a day keeps the frown away.",
    futurePlans = "Aims to win the pun championship next year",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Bianca Thunderfoot",
    bestMemory = "Won a storytelling contest with an improvised rhyme about a dragon",
    image = nil,
    quote = "Life is a poem waiting to be written.",
    futurePlans = "Wants to write a bestselling poetry book",
    favoriteDnDClass = "Cleric",
    inGuild = false,
  },
  {
    name = "Bridget Twinklepaws",
    bestMemory = "Once identified a rare tree by its leaf pattern during a hiking trip",
    image = nil,
    quote = "The forest speaks in whispers, if you’re quiet enough to listen.",
    futurePlans = "Wants to write a guidebook on identifying trees",
    favoriteDnDClass = "Ranger",
    inGuild = false,
  },
  {
    name = "Cesare McQuack",
    bestMemory = "Had a duck race with his collection of rubber ducks at the local pond",
    image = nil,
    quote = "The duck that quacks last quacks the loudest.",
    futurePlans = "Plans to open a rubber duck racing league",
    favoriteDnDClass = "Barbarian",
    inGuild = false,
  },
  {
    name = "Cecil Whimsyfoot",
    bestMemory = "Lost an entire day reading cheesy romance novels by the beach",
    image = nil,
    quote = "True love is in the pages, waiting to be discovered.",
    futurePlans = "Wants to write a bestselling romance novel",
    favoriteDnDClass = "Paladin",
    inGuild = false,
  },
  {
    name = "Desdemona Wiffle",
    bestMemory = "Once wrote herself a secret note that made her laugh for hours",
    image = nil,
    quote = "Sometimes, the best advice comes from your own mind.",
    futurePlans = "Plans to start a journal writing workshop",
    favoriteDnDClass = "Sorcerer",
    inGuild = false,
  },
  {
    name = "Dina Fizzlesnoot",
    bestMemory = "Had a scarf fashion show with 40 different scarves at a family gathering",
    image = nil,
    quote = "A scarf can be the most fun accessory.",
    futurePlans = "Wants to start a scarf design business",
    favoriteDnDClass = "Monk",
    inGuild = false,
  },
  {
    name = "Domenico Twizzler",
    bestMemory = "Had ice cream delivered to his house on a snowy day, just because",
    image = nil,
    quote = "There’s no wrong time for ice cream.",
    futurePlans = "Wants to open an ice cream truck business",
    favoriteDnDClass = "Fighter",
    inGuild = false,
  },
  {
    name = "Elliott McMuffins",
    bestMemory = "Once impressed everyone by humming two songs at once at a talent show",
    image = nil,
    quote = "Music is the language of the soul.",
    futurePlans = "Plans to join a band as a vocalist",
    favoriteDnDClass = "Wizard",
    inGuild = false,
  },
  {
    name = "Emma Zoodle",
    bestMemory = "Quoted every line from her favorite movie during a sleepover marathon",
    image = nil,
    quote = "A good movie is a friend you visit again and again.",
    futurePlans = "Wants to start a movie review blog",
    favoriteDnDClass = "Warlock",
    inGuild = false,
  },
  {
    name = "Ephraim Snorkelstein",
    bestMemory = "Won a trivia night by correctly answering obscure questions about history",
    image = nil,
    quote = "The more you know, the more you can enjoy the world.",
    futurePlans = "Plans to start a trivia game show",
    favoriteDnDClass = "Ranger",
    inGuild = false,
  },
  {
    name = "Flora Snickerwhistle",
    bestMemory = "Had an in-depth conversation with a plant for an entire afternoon",
    image = nil,
    quote = "Plants have stories too, if you listen closely.",
    futurePlans = "Wants to start a plant-based wellness business",
    favoriteDnDClass = "Druid",
    inGuild = false,
  },
  {
    name = "Florentino Lollington",
    bestMemory = "Told the best dad joke at a family reunion, everyone laughed for hours",
    image = nil,
    quote = "The cornier, the better.",
    futurePlans = "Wants to write a book of dad jokes",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Francesco O'Pajamas",
    bestMemory = "Once spent an entire weekend in pajamas, binge-watching his favorite show",
    image = nil,
    quote = "Comfort first, always.",
    futurePlans = "Wants to start a loungewear line",
    favoriteDnDClass = "Monk",
    inGuild = false,
  },
  {
    name = "Filippo Lollington",
    bestMemory = "Had a dad joke-off with Florentino at a family gathering",
    image = nil,
    quote = "A good dad joke is always appreciated.",
    futurePlans = "Wants to open a dad joke appreciation club",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Ginevra Popcorn",
    bestMemory = "Recited the alphabet backwards as a party trick that amazed everyone",
    image = nil,
    quote = "The alphabet is full of surprises.",
    futurePlans = "Plans to become a professional party entertainer",
    favoriteDnDClass = "Sorcerer",
    inGuild = false,
  },
  {
    name = "Giorgio Snickerdoodle",
    bestMemory = "Invented a hilarious conspiracy theory about talking squirrels",
    image = nil,
    quote = "The truth is out there... in the bushes.",
    futurePlans = "Wants to write a comedic book on conspiracy theories",
    favoriteDnDClass = "Rogue",
    inGuild = false,
  },
  {
    name = "Gilbert Fizzlebop",
    bestMemory = "Created a hat collection that became famous at his local flea market",
    image = nil,
    quote = "A hat is more than just an accessory; it’s an attitude.",
    futurePlans = "Plans to open a boutique hat shop",
    favoriteDnDClass = "Fighter",
    inGuild = false,
  },
  {
    name = "Harald Snickers",
    bestMemory = "Once had a deep conversation with a houseplant about life’s mysteries",
    image = nil,
    quote = "Even plants have secrets to share.",
    futurePlans = "Wants to open a meditation center surrounded by plants",
    favoriteDnDClass = "Cleric",
    inGuild = false,
  },
  {
    name = "Harriet Muffinwhisk",
    bestMemory = "Managed to balance a spoon on her nose for five minutes straight at a talent show",
    image = nil,
    quote = "Life’s a balance.",
    futurePlans = "Wants to create a viral spoon-balancing challenge",
    favoriteDnDClass = "Monk",
    inGuild = false,
  },
  {
    name = "Hana Stardancer",
    bestMemory = "Juggled three flaming torches at a street performance without dropping a single one",
    image = nil,
    quote = "Every great performance is just a little bit of magic.",
    futurePlans = "Wants to travel the world performing circus tricks",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Ike Twinkleboots",
    bestMemory = "Once made the entire tavern laugh by telling a ridiculous story about a dancing goat",
    image = nil,
    quote = "You can't beat a good laugh!",
    futurePlans = "To become the town's funniest entertainer",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Ivy Gigglequack",
    bestMemory = "Had an unforgettable day at the amusement park, conquering the roller coaster after a panic attack",
    image = nil,
    quote = "Just close your eyes and hold on tight!",
    futurePlans = "To conquer more roller coasters, no matter the height",
    favoriteDnDClass = "Ranger",
    inGuild = false,
  },
  {
    name = "Jacopo Pogo",
    bestMemory = "Impressed everyone by playing an entire concert with just a kazoo",
    image = nil,
    quote = "Sometimes a kazoo is all you need.",
    futurePlans = "To tour the world as a kazoo virtuoso",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Jasmine Flapdoodle",
    bestMemory = "Once collected postcards from every country in a single summer",
    image = nil,
    quote = "Postcards are little pieces of the world.",
    futurePlans = "To open a postcard shop and share her collections",
    favoriteDnDClass = "Sorcerer",
    inGuild = false,
  },
  {
    name = "Klaus Bumblepants",
    bestMemory = "Won a bet by reciting Shakespeare's sonnet backwards during a performance",
    image = nil,
    quote = "Words are power, even when they're backwards.",
    futurePlans = "To create a Shakespearean theater troupe",
    favoriteDnDClass = "Wizard",
    inGuild = false,
  },
  {
    name = "Laura Thunderpants",
    bestMemory = "Had a heart-stopping moment when a butterfly landed on her during a nature hike",
    image = nil,
    quote = "I'm a warrior, but butterflies... not so much.",
    futurePlans = "To overcome her fear of butterflies",
    favoriteDnDClass = "Barbarian",
    inGuild = false,
  },
  {
    name = "Lena Taterbop",
    bestMemory = "Saved the day by providing snacks during a long, boring meeting",
    image = nil,
    quote = "A snack a day keeps the grumpiness away.",
    futurePlans = "To create the ultimate snack empire",
    favoriteDnDClass = "Druid",
    inGuild = false,
  },
  {
    name = "Miles Quirkendorf",
    bestMemory = "Made an epic pizza at a family gathering with pineapple and unexpected toppings",
    image = nil,
    quote = "Pineapple belongs where the heart is – on pizza!",
    futurePlans = "To open a pizza restaurant that defies all food rules",
    favoriteDnDClass = "Monk",
    inGuild = false,
  },
  {
    name = "Mortimer Quackfoot",
    bestMemory = "Had a magical experience when he woke up on Christmas morning to find presents from Santa",
    image = nil,
    quote = "Santa’s real, I’ve seen the evidence.",
    futurePlans = "To find the perfect gift for everyone he meets",
    favoriteDnDClass = "Cleric",
    inGuild = false,
  },
  {
    name = "Nellie Jumblebean",
    bestMemory = "Managed to balance 10 pencils on her nose during a school talent show",
    image = nil,
    quote = "Balance is key, in life and in talent shows.",
    futurePlans = "To master the art of balancing anything and everything",
    favoriteDnDClass = "Rogue",
    inGuild = false,
  },
  {
    name = "Nina Doodleflop",
    bestMemory = "Created a whole new word and convinced everyone in her class to use it for a day",
    image = nil,
    quote = "If you can't find the right word, make one up!",
    futurePlans = "To become a dictionary editor and add her own words",
    favoriteDnDClass = "Wizard",
    inGuild = false,
  },
  {
    name = "Olga Waffleton",
    bestMemory = "Had a heartwarming moment when Steve the turtle saved her favorite sock from being eaten by her dog",
    image = nil,
    quote = "Pets are heroes in disguise.",
    futurePlans = "To write a memoir about her life with Steve",
    favoriteDnDClass = "Paladin",
    inGuild = false,
  },
  {
    name = "Olivier Fumbleton",
    bestMemory = "Once ate an entire sandwich, crusts and all, without noticing it was someone's lunch",
    image = nil,
    quote = "Crusts? Don’t need to worry about them.",
    futurePlans = "To master the art of sandwich-making",
    favoriteDnDClass = "Fighter",
    inGuild = false,
  },
  {
    name = "Oscar Muffinfeet",
    bestMemory = "Had a cozy nap on a rainy day with his favorite socks on, and a warm cup of tea by his side",
    image = nil,
    quote = "The best naps happen with socks and tea.",
    futurePlans = "To nap in every comfortable place he can find",
    favoriteDnDClass = "Barbarian",
    inGuild = false,
  },
  {
    name = "Oscar Wigglytoes",
    bestMemory = "Danced around the house in the middle of the night, pretending to be a disco star while brushing his teeth",
    image = nil,
    quote = "A little dance can fix anything, even brushing your teeth.",
    futurePlans = "To become a dance instructor for night owls",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Penelope Soggytoes",
    bestMemory = "Had a panic attack when a butterfly landed on her, but later laughed about it with friends",
    image = nil,
    quote = "Fear doesn’t last forever, but laughter does.",
    futurePlans = "To face her fear and laugh at butterflies",
    favoriteDnDClass = "Warlock",
    inGuild = false,
  },
  {
    name = "Pietro Limoncello",
    bestMemory = "Made everyone laugh with his perfect duck impression during a family dinner",
    image = nil,
    quote = "Quack! See? Perfect.",
    futurePlans = "To perfect his duck impression and perform at local comedy clubs",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Quentin Swoosh",
    bestMemory = "Won every staring contest at summer camp and earned the title of 'Champion Stare' for the year",
    image = nil,
    quote = "You can win with your eyes closed, if you believe in yourself.",
    futurePlans = "To hold the world record for staring contests",
    favoriteDnDClass = "Rogue",
    inGuild = false,
  },
  {
    name = "Quincy Snorfblat",
    bestMemory = "Impressed his friends by wiggling his ears independently at a party",
    image = nil,
    quote = "It’s all about ear control.",
    futurePlans = "To teach everyone how to wiggle their ears",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Renee Marshmellow",
    bestMemory = "Found a lucky coin in a wishing well and made a wish that came true the very next day",
    image = nil,
    quote = "Sometimes, all you need is a lucky coin.",
    futurePlans = "To collect all the lucky coins in the world",
    favoriteDnDClass = "Sorcerer",
    inGuild = false,
  },
  {
    name = "Rosa Bloop",
    bestMemory = "Discovered the perfect iced coffee recipe and shared it with everyone in the office",
    image = nil,
    quote = "Iced coffee, the ultimate summer refreshment.",
    futurePlans = "To open a coffee shop dedicated to iced coffee",
    favoriteDnDClass = "Druid",
    inGuild = false,
  },
  {
    name = "Rosalie Tiddlybop",
    bestMemory = "Refused to eat blue foods at a birthday party, but eventually tried and loved a blueberry muffin",
    image = nil,
    quote = "Blue foods aren't so bad after all.",
    futurePlans = "To try every color of food and share her experiences",
    favoriteDnDClass = "Wizard",
    inGuild = false,
  },
  {
    name = "Sebastian Waddle",
    bestMemory = "Had a deep conversation with himself in the mirror and realized he needed to be more confident",
    image = nil,
    quote = "Sometimes, the best advice comes from within.",
    futurePlans = "To become more confident and help others find their inner strength",
    favoriteDnDClass = "Paladin",
    inGuild = false,
  },
  {
    name = "Silvio Quirk",
    bestMemory = "Napped on a hammock while it was raining, feeling at peace with the world",
    image = nil,
    quote = "Napping is an art form.",
    futurePlans = "To nap in every hammock in the world",
    favoriteDnDClass = "Monk",
    inGuild = false,
  },
  {
    name = "Tasha Flibberflop",
    bestMemory = "Spent a whole day speaking fluent pirate, confusing everyone at the market",
    image = nil,
    quote = "Arr matey, speak like a pirate!",
    futurePlans = "To become a pirate linguist and teach others how to speak like a pirate",
    favoriteDnDClass = "Rogue",
    inGuild = false,
  },
  {
    name = "Teodoro Tumbleweed",
    bestMemory = "Found a lucky penny on the ground and used it to win a game of chance later that day",
    image = nil,
    quote = "Luck is just a penny away.",
    futurePlans = "To collect every lucky penny he can find",
    favoriteDnDClass = "Bard",
    inGuild = false,
  },
  {
    name = "Ulrich Squigglefist",
    bestMemory = "Had his pet hamster, Pudding, perform tricks for a crowd at a local festival",
    image = nil,
    quote = "Pudding’s the true star of the show.",
    futurePlans = "To train Pudding to become the most famous hamster in the world",
    favoriteDnDClass = "Fighter",
    inGuild = false,
  },
  {
    name = "Valerie Gobblepants",
    bestMemory = "Ate breakfast for dinner with friends, laughing until their stomachs hurt",
    image = nil,
    quote = "Who says breakfast is just for the morning?",
    futurePlans = "To have breakfast for dinner every Friday night",
    favoriteDnDClass = "Barbarian",
    inGuild = false,
  },
  {
    name = "Valerio Doodlepop",
    bestMemory = "Always carries a notebook to sketch the world around him, even during boring meetings",
    image = nil,
    quote = "You never know when inspiration will strike.",
    futurePlans = "To become a famous artist",
    favoriteDnDClass = "Sorcerer",
    inGuild = false,
  },
  {
    name = "Wendy Squish",
    bestMemory = "Scared herself silly by watching horror movies alone, but laughed at her own fear afterward",
    image = nil,
    quote = "The best part is always laughing at how scared you were.",
    futurePlans = "To become a horror movie expert",
    favoriteDnDClass = "Ranger",
    inGuild = false,
  },
  {
    name = "Xander Pudding",
    bestMemory = "Had a conversation with his reflection, which helped him get through a tough day",
    image = nil,
    quote = "Sometimes, you need to talk it out with yourself.",
    futurePlans = "To become more introspective and help others do the same",
    favoriteDnDClass = "Warlock",
    inGuild = false,
  },
  {
    name = "Yvonne Jigglybean",
    bestMemory = "Wore 10 pairs of socks at once for a charity event and became an internet sensation",
    image = nil,
    quote = "Socks are life.",
    futurePlans = "To break the world record for most socks worn at once",
    favoriteDnDClass = "Paladin",
    inGuild = false,
  },
  {
    name = "Zaccaria Floop",
    bestMemory = "Had a hilarious moment when he tried chocolate for the first time and didn’t like it",
    image = nil,
    quote = "Chocolate's just not for me.",
    futurePlans = "To find the perfect dessert for his taste",
    favoriteDnDClass = "Monk",
    inGuild = false,
  },
  {
    name = "Zelda Bloopington",
    bestMemory = "Hiccupped uncontrollably during a speech, but turned it into a comedy routine",
    image = nil,
    quote = "Hiccups are just opportunities for humor.",
    futurePlans = "To become a public speaker who embraces the unexpected",
    favoriteDnDClass = "Sorcerer",
    inGuild = false,
  }
}


function constants.setFont(font, size)
  return love.graphics.setFont(love.graphics.newFont("assets/font/" .. font .. ".ttf", size))
end

return constants
