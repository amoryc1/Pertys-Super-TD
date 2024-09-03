extends Node


var gameversion = "3.09.2024 / v0.06"

var ticksAtLoadStart = 0

var money = 0
var health = 100

var hasLoadedData = false

var chosenSaveFile = "SaveFile1"
var showDebug = false
var fpsCap = 60
var vsyncMode = "Enabled"
var windowMode = "Windowed"
var musicVolume = 1
var sfxVolume = 1
var masterVolume = 1
var levelWin = {
	"The Park": "no"
}
var difficultys = ["no","Easy","Normal","Hard","Hardcore"]


var placedTowers = {
	"Pencil Tower": 0,
	"Gabby's Book": 0,
	"Glue Gunner": 0,
	"Redwood Worker": 0,
	"Flamethrower": 0,
	"Ruler Tower": 0
}

var towerUpgrades = {
	"Pencil Tower": {
		1: { # tier 1 upgrades
			1: {
				"name": "Sharper Pencils",
				"desc": "Pencils thrown by this tower can pierce 2 more Pertys",
				"cost": 175,
				"sprite": "normal/upgrades/sharperPencils.png" # Location in the assets/towers
			},
			2: {
				"name": "Super Sharp Pencils",
				"desc": "Can pierce 4 more Pertys and can pop Metal Pertys. Does 3 more damage",
				"cost": 525,
				"sprite": "normal/upgrades/superSharpPencils.png" # Location in the assets/towers
			},
			3: {
				"name": "Unnecessarily Sharp Pencils",
				"desc": "Pierces 15 Pertys and does 6 more damage",
				"cost": 1450,
				"sprite": "normal/upgrades/uSharpPencils.png" # Location in the assets/towers
			}
		},
		2: { # tier 2 upgrades
			1: {
				"name": "Super Goggles",
				"desc": "Increases the range this tower can spot Pertys",
				"cost": 125,
				"sprite": "normal/upgrades/hivisionGoggles.png" # Location in the assets/towers
			},
			2: {
				"name": "20/20 vision",
				"desc": "Even more range and can see camo Pertys",
				"cost": 420,
				"sprite": "normal/upgrades/2020vision.png" # Location in the assets/towers
			},
			3: {
				"name": "Scoped Pencils",
				"desc": "A ton more range. Thrown pencils also move slightly faster",
				"cost": 800,
				"sprite": "normal/upgrades/scopedPencil.png" # Location in the assets/towers
			}
		},
		3: { # tier 3 upgrades
			1: {
				"name": "Faster Throwing",
				"desc": "Throws pencils quicker and more frequently",
				"cost": 130,
				"sprite": "normal/upgrades/fasterThrowing.png" # Location in the assets/towers
			},
			2: {
				"name": "Robot Arm",
				"desc": "Using a robot arm, this tower can throw pencils super duper fast and make new pencils super quick",
				"cost": 540,
				"sprite": "normal/upgrades/robotArm.png" # Location in the assets/towers
			},
			3: {
				"name": "Rocket Propelled Pencils",
				"desc": "Throws an RPP instead of a pencil which are extremely fast. Also deals more damage since they are that fast. Can pop Metal Pertys",
				"cost": 1400,
				"sprite": "normal/upgrades/rpp.png" # Location in the assets/towers
			}
		},
	},
	"Glue Gunner": {
		1: {
			1: {
					"name": "Stronger Glue",
					"desc": "Glue soaks through 3 more perty layers",
					"cost": 300,
					"sprite": "glue/upgrades/strongerglue.png" # Location in the assets/towers
			},
			2: {
					"name": "Super Strong Glue",
					"desc": "Glue soaks through 5 more perty layers and reduces their speed to 25%",
					"cost": 800,
					"sprite": "glue/upgrades/superstrongglue.png" # Location in the assets/towers
			},
			3: {
					"name": "Omega Glue",
					"desc": "Glue soaks through all perty layers and slows them down to 10% their normal speed",
					"cost": 1500,
					"sprite": "glue/upgrades/omegaglue.png" # Location in the assets/towers
			}
		},
		2: {
			1: {
					"name": "Reinforced Tubes",
					"desc": "Fires Glue at a faster rate and move faster",
					"cost": 250,
					"sprite": "glue/upgrades/strongertubes.png" # Location in the assets/towers
			},
			2: {
					"name": "Diamond Tubes",
					"desc": "Super fast fire rate and move faster",
					"cost": 550,
					"sprite": "glue/upgrades/diamondtubes.png" # Location in the assets/towers
			},
			3: {
					"name": "Steroids",
					"desc": "Give the tube steroids to enable it to fire 4x faster and move faster",
					"cost": 1000,
					"sprite": "glue/upgrades/steriods.png" # Location in the assets/towers
			}
		},
		3: {
			1: {
					"name": "Pebble Glue",
					"desc": "Glue deals 1 damage",
					"cost": 200,
					"sprite": "glue/upgrades/pebbleglue.png" # Location in the assets/towers
			},
			2: {
					"name": "Rock Glue",
					"desc": "Glue deals 4 more damage and +1 piercing",
					"cost": 400,
					"sprite": "glue/upgrades/rockglue.png" # Location in the assets/towers
			},
			3: {
					"name": "Boulder Glue",
					"desc": "Glue deals 8 more damage and +3 piercing",
					"cost": 800,
					"sprite": "glue/upgrades/boulderglue.png" # Location in the assets/towers
			}
		},
	},
	"Redwood Worker": {
		1: {
			1: {
					"name": "Stonks",
					"desc": "Gold is worth 20 more when picked up",
					"cost": 750,
					"sprite": "redwoodworker/upgrades/stonks.png" # Location in the assets/towers
			},
			2: {
					"name": "Gold NFTs",
					"desc": "Publish NFTs of the gold sprite to make 25 more cash",
					"cost": 1300,
					"sprite": "redwoodworker/upgrades/nft.png" # Location in the assets/towers
			},
			3: {
					"name": "Lie on WallStreetBets",
					"desc": "Make WallStreetBets think Gold is valuable. Get 30 more cash",
					"cost": 1900,
					"sprite": "redwoodworker/upgrades/wsb.png" # Location in the assets/towers
			}
		},
		2: {
			1: {
					"name": "Bigger Gold Chunks",
					"desc": "Gold lasts slightly longer and is bigger",
					"cost": 600,
					"sprite": "redwoodworker/upgrades/biggerbits.png" # Location in the assets/towers
			},
			2: {
					"name": "Biggest Gold Chunks",
					"desc": "Enchant your pickaxe to make gold bigger and last even longer",
					"cost": 900,
					"sprite": "redwoodworker/upgrades/superlargegoldwoahitssobigiwonderhowmuchitsworth.png" # Location in the assets/towers
			},
			3: {
					"name": "Conveyor Belts",
					"desc": "Make the gold automatically get collected",
					"cost": 1200,
					"sprite": "redwoodworker/upgrades/conveyorbelt.png" # Location in the assets/towers
			}
		},
		3: {
			1: {
					"name": "More Gold",
					"desc": "Spawn 3 more bits per wave",
					"cost": 800,
					"sprite": "redwoodworker/upgrades/moregold.png" # Location in the assets/towers
			},
			2: {
					"name": "Fortune",
					"desc": "Spawn 5 more bits per wave",
					"cost": 1400,
					"sprite": "redwoodworker/upgrades/fortIII.png" # Location in the assets/towers
			},
			3: {
					"name": "Duplication Glitches",
					"desc": "Spawn 10 more bits per wave",
					"cost": 2000,
					"sprite": "redwoodworker/upgrades/rule5noduping.png" # Location in the assets/towers
			}
		},
	},
	"Flamethrower": {
		1: {
			1: {
				"name": "Filtered Canisters",
				"desc": "Filter cantisters to only allow pure oxygen. Fireball is larger when in contact and lasts longer",
				"cost": 700,
				"sprite": "flamethrower/upgrades/filter.png" # Location in the assets/towers
			},
			2: {
				"name": "Gunpowder Enfused Flame",
				"desc": "Apply gunpowder to the flame to increase size and duration",
				"cost": 1200,
				"sprite": "flamethrower/upgrades/gunpowderflame.png" # Location in the assets/towers
			},
			3: {
				"name": "Nuclear Flame",
				"desc": "Attach a small necluar generator to the canister. A very large area of effect and deals more damage",
				"cost": 2000,
				"sprite": "flamethrower/upgrades/nuclear.png" # Location in the assets/towers
			},
		},
		2: {
			1: {
				"name": "Better Fuel Mix",
				"desc": "Create a new chemical formula to maximise efficency. Increases damage of the flame by 5",
				"cost": 800,
				"sprite": "flamethrower/upgrades/betterfuel.png" # Location in the assets/towers
			},
			2: {
				"name": "Molten Liquid",
				"desc": "Infuses the flame with a molten metal to increase damage by 10",
				"cost": 1400,
				"sprite": "flamethrower/upgrades/moltenflame.png" # Location in the assets/towers
			},
			3: {
				"name": "Mystic Flame",
				"desc": "Get a new mix from the heavens, increasing damage by 15",
				"cost": 2000,
				"sprite": "flamethrower/upgrades/mysticflame.png" # Location in the assets/towers
			},
		},
		3: {
			1: {
				"name": "Hot Flame",
				"desc": "Increase the heat of the flame causing it to reach further. Higher detection range.",
				"cost": 600,
				"sprite": "flamethrower/upgrades/gel1.png" # Location in the assets/towers
			},
			2: {
				"name": "Hotter Flame",
				"desc": "Apply a gel to the flame to heat it, melting of the 'Metal' status of a Perty.",
				"cost": 800,
				"sprite": "flamethrower/upgrades/gel2.png" # Location in the assets/towers
			},
			3: {
				"name": "Hottest Flame",
				"desc": "Apply more gel, stripping of the 'Camo' status of a Perty.",
				"cost": 1250,
				"sprite": "flamethrower/upgrades/gel3.png" # Location in the assets/towers
			},
		}
	},
	"Ruler Tower": {
		1: { # tier 1 upgrades
			1: {
				"name": "Recycling",
				"desc": "Recycle nearby litter to make more rulers allowing the use of 1 more.",
				"cost": 350,
				"sprite": "normal/upgrades/sharperPencils.png" # Location in the assets/towers
			},
			2: {
				"name": "Oil Farms",
				"desc": "Make oil rig to get more oil for more rulers. Allows use of 2 more.",
				"cost": 700,
				"sprite": "normal/upgrades/superSharpPencils.png" # Location in the assets/towers
			},
			3: {
				"name": "Discover an Element",
				"desc": "Discover a new element and use it for the creation of rulers. Allows use of 4 more.",
				"cost": 1300,
				"sprite": "normal/upgrades/uSharpPencils.png" # Location in the assets/towers
			}
		},
		2: { # tier 2 upgrades
			1: {
				"name": "Chipped Ruler",
				"desc": "Chip off ends of the ruler to increase damage and pierce",
				"cost": 400,
				"sprite": "normal/upgrades/hivisionGoggles.png" # Location in the assets/towers
			},
			2: {
				"name": "Hidden Razorblade",
				"desc": "Hide a razorblade in the ruler to make it hurt more and more durable",
				"cost": 750,
				"sprite": "normal/upgrades/2020vision.png" # Location in the assets/towers
			},
			3: {
				"name": "Hot Ruler",
				"desc": "Dip the ruler in a hot liquid. Has more pierce and can hit Metal pertys",
				"cost": 1200,
				"sprite": "normal/upgrades/scopedPencil.png" # Location in the assets/towers
			}
		},
		3: { # tier 3 upgrades
			1: {
				"name": "High Range Ruler",
				"desc": "Rulers can travel further and increased tower range",
				"cost": 300,
				"sprite": "normal/upgrades/fasterThrowing.png" # Location in the assets/towers
			},
			2: {
				"name": "Turbo Ruler",
				"desc": "Expose the ruler to turbo radiation making it faster, go further and more tower range.",
				"cost": 650,
				"sprite": "normal/upgrades/robotArm.png" # Location in the assets/towers
			},
			3: {
				"name": "Genetic Enhancment",
				"desc": "Change tower genetics to throw the ruler further and a lot faster.",
				"cost": 1337,
				"sprite": "normal/upgrades/rpp.png" # Location in the assets/towers
			}
		},
	},
}



var placingTower = ""
var inGame = false
var maxHealth = 150
var startingMoney = 225
var levelName = "placeholder_level_name"
var basePertySpeed = 1.5
var inWave = false
var waveNumber = 1
var won = false
var estimatedTimeForSpawns = 1 # Redwood Worker uses this

var mouseHoverStackCollision = 0
var mouseHoverOverPath = false
var mouseHoverOverWater = false



var pertyStages = {
	"normal": ["res://nodes/enemies/Perty.tscn", "res://assets/enemies/perty.png"],
	"blue": ["res://nodes/enemies/BluePerty.tscn", "res://assets/enemies/bluePerty.png"],
	"green": ["res://nodes/enemies/GreenPerty.tscn", "res://assets/enemies/greenPerty.png"],
	"yellow": ["res://nodes/enemies/YellowPerty.tscn", "res://assets/enemies/yellowPerty.png"],
	"pink": ["res://nodes/enemies/PinkPerty.tscn", "res://assets/enemies/pinkPerty.png"],
	"rainbow": ["res://nodes/enemies/RainbowPerty.tscn", "res://assets/enemies/rainbowPerty.png"],
	}


func _ready():
	Engine.max_fps = 60 # caps at 60 because of the way the pertys move not taking fps into acount to move smoothly.

func _process(_delta):
	if health <= 0 and inGame:
		inGame = false
		placingTower = ""
		ticksAtLoadStart = Time.get_ticks_msec()
		get_tree().change_scene_to_file("res://nodes/menu/menu.tscn")
		await get_tree().create_timer(0.02).timeout
		var musicnode = get_node("../Menu/BGM")
		Engine.time_scale = 1
		musicnode.stream = load("res://music/other/youdied.ogg")
		musicnode.play()


func win_game(levelDifficulty, levelName):
	var currentInArray = difficultys.find(levelWin[levelName])
	var newInArray = difficultys.find(levelDifficulty)
	
	if newInArray > currentInArray:
		levelWin[levelName] = levelDifficulty
		
	save_data(chosenSaveFile)
	
	inGame = false
	ticksAtLoadStart = Time.get_ticks_msec()
	get_tree().change_scene_to_file("res://nodes/menu/menu.tscn")
	won = true


func format_with_commas(number):
	var str_number = str(number)
	var result = ""
	var counter = 0
	
	for i in range(str_number.length() - 1, -1, -1):
		if counter == 3:
			result = "," + result
			counter = 0
		result = str_number[i] + result
		counter += 1
	
	return result

# I want to marry ChatGPT thank you so much for this pookie <3

func save_data(filename):
	var savePath = "user://" + str(filename) + ".json"
	
	var data = {
		"masterVolume": masterVolume,
		"musicVolume": musicVolume,
		"sfxVolume": sfxVolume,
		"timeOfLastSave": str(Time.get_datetime_dict_from_system()),
		"fpsCap": fpsCap,
		"vsyncMode": vsyncMode,
		"levelWin": levelWin,
		"windowMode": windowMode,
		"showDebug": showDebug,
		"placedTowers": placedTowers,
	}
	
	var json_string = JSON.stringify(data)
	
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
		print("Successfully saved data as JSON. Path: ", file.get_path_absolute())
		return [true, file.get_path_absolute()]
	else:
		print("Failed to open save file for writing.")
		return false

func load_data(filename):
	var savePath = "user://" + str(filename) + ".json"

	var file = FileAccess.open(savePath, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()

		var data = JSON.parse_string(json_string)
		
		# pray the file isnt broken
		if "masterVolume" in data: masterVolume = data.masterVolume
		if "musicVolume" in data: musicVolume = data.musicVolume
		if "sfxVolume" in data: sfxVolume = data.sfxVolume
		if "fpsCap" in data: fpsCap = data.fpsCap
		if "vsyncMode" in data: vsyncMode = data.vsyncMode
		if "windowMode" in data: windowMode = data.windowMode
		if "showDebug" in data: showDebug = data.showDebug
		
		# Achievements
		# Loop through all data in levelWin dict and if it exists set the value
		if "levelWin" in data:
			for x in levelWin:
				if x in data.levelWin: levelWin[x] = data.levelWin[x]
		# Placed towers
		if "placedTowers" in data:
			for x in placedTowers:
				if x in data.placedTowers: placedTowers[x] = data.placedTowers[x]
		
		
		print("Loaded data from JSON")
	else:
		print("Save file not found, using default values.")

