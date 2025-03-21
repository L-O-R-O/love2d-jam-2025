local constants = {}

-- fonts
constants.FONTS_MAIN_MENU = love.graphics.newFont("assets/font/NiceChalk.ttf", 50)
constants.FONTS_SUB_MENU  = love.graphics.newFont("assets/font/NiceChalk.ttf", 40)
constants.FONTS_ROBOTO    = love.graphics.newFont("assets/font/Roboto-Black.ttf", 20)
constants.FONTS_NICE_CHALK = love.graphics.newFont("assets/font/NiceChalk.ttf", 20)
constants.FONTS_CALENDAR_MONTH = love.graphics.newFont("assets/font/NiceChalk.ttf", 70)

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

-- courses/activities images
constants.IMAGES_CS_BG               = love.graphics.newImage("assets/images/activities/activities.png")
constants.IMAGES_CS_ARROWS_NONE      = love.graphics.newImage("assets/images/activities/activities_arrow_none.png")
constants.IMAGES_CS_ARROWS_LEFT      = love.graphics.newImage("assets/images/activities/activities_arrow_left.png")
constants.IMAGES_CS_ARROWS_RIGHT     = love.graphics.newImage("assets/images/activities/activities_arrow_right.png")
constants.IMAGES_CS_ACTIVITY_CARD_BG = love.graphics.newImage("assets/images/activities/activities_info.png")

-- sounds
constants.SOUNDS_MOUSE_CLICK = love.audio.newSource("assets/sounds/click.mp3", "static")
constants.SOUNDS_PAGE_TURN   = love.audio.newSource("assets/sounds/pages.mp3", "static")

-- scenes
constants.SCENES_DESKTOP  = "desktop"
constants.SCENES_CALENDAR = "calendar"
constants.SCENES_COMPUTER = "computer"
constants.SCENES_YEARBOOK = "yearbook"
constants.SCENES_COURSES  = "courses"
constants.SCENES_AGENDA   = "agenda"
constants.SCENES_TITLE    = "title"
constants.SCENES_YEARBOOK = "yearBook"
constants.SCENES_YEARBOOK_STUDENT_CARD  = "yearBookStudentCard"
constants.SCENES_COURSES_ACTIVITY_CARD  = "coursesActivityCard"

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
constants.MONTH_NAMES = {
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
}

constants.WEEK_DAYS = {
  [1] = "Monday", [2] = "Tuesday", [3] = "Wednesday",
  [4] = "Thursday", [5] = "Friday", [6] = "Saturday", [7] = "Sunday"
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
  soccer =        {0,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  basket =        {1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  golf =          {1,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  PartyHard =     {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1},
  swimming =      {1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  chess =         {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1}
}

-- Studenti
constants.STUDENTS = {
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

function constants.setFont(font, size)
  return love.graphics.setFont(love.graphics.newFont("assets/font/"..font..".ttf", size))
end

return constants
