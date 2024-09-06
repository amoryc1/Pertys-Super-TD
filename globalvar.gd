extends Node


var game_version = "beta 0.07 / 2024-09-04"

var ticks_at_load_start = 0

var money = 0
var health = 100

var has_loaded_data = false

var chosen_save_file = "SaveFile1"
var show_debug = false
var fps_cap = 60
var vsync_mode = "Enabled"
var window_mode = "Windowed"
var music_volume = 1
var sfx_volume = 1
var master_volume = 1
var level_win = {
	"The Park": "no"
}
var shadows_enabled = true
var shadow_level = "pcf5"



var difficultys = ["no","Easy","Normal","Hard","Hardcore"]


var placed_towers = {
	"Pencil Tower": 0,
	"Gabby's Book": 0,
	"Glue Gunner": 0,
	"Redwood Worker": 0,
	"Flamethrower": 0,
	"Ruler Tower": 0
}

var tower_upgrades = {
	"Pencil Tower": {
		1: { # tier 1 upgrades
			1: {
				"name": "Sharper Pencils",
				"desc": "Pencils thrown by this tower can pierce 2 more Pertys",
				"cost": 175,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 0,
			},
			2: {
				"name": "Super Sharp Pencils",
				"desc": "Can pierce 4 more Pertys and can pop Metal Pertys. Does 3 more damage",
				"cost": 525,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 1,
			},
			3: {
				"name": "Unnecessarily Sharp Pencils",
				"desc": "Pierces 15 Pertys and does 6 more damage",
				"cost": 1450,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 2,
			}
		},
		2: { # tier 2 upgrades
			1: {
				"name": "Super Goggles",
				"desc": "Increases the range this tower can spot Pertys",
				"cost": 125,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 3,
			},
			2: {
				"name": "20/20 vision",
				"desc": "Even more range and can see camo Pertys",
				"cost": 420,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 4,
			},
			3: {
				"name": "Scoped Pencils",
				"desc": "A ton more range. Thrown pencils also move slightly faster",
				"cost": 800,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 5,
			}
		},
		3: { # tier 3 upgrades
			1: {
				"name": "Faster Throwing",
				"desc": "Throws pencils quicker and more frequently",
				"cost": 130,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 6,
			},
			2: {
				"name": "Robot Arm",
				"desc": "Using a robot arm, this tower can throw pencils super duper fast and make new pencils super quick",
				"cost": 540,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 7,
			},
			3: {
				"name": "Rocket Propelled Pencils",
				"desc": "Throws an RPP instead of a pencil which are extremely fast. Also deals more damage since they are that fast. Can pop Metal Pertys",
				"cost": 1400,
				"sprite": "normal/upgrades.png", # Location in the assets/towers
				"spriteFrame": 8,
			}
		},
	},
	"Glue Gunner": {
		1: {
			1: {
				"name": "Stronger Glue",
				"desc": "Glue soaks through 3 more perty layers",
				"cost": 300,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 0,
			},
			2: {
				"name": "Super Strong Glue",
				"desc": "Glue soaks through 5 more perty layers and reduces their speed to 25%",
				"cost": 800,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 1,
			},
			3: {
				"name": "Omega Glue",
				"desc": "Glue soaks through all perty layers and slows them down to 10% their normal speed",
				"cost": 1500,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 2,
			}
		},
		2: {
			1: {
				"name": "Reinforced Tubes",
				"desc": "Fires Glue at a faster rate and move faster",
				"cost": 250,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 3,
			},
			2: {
				"name": "Diamond Tubes",
				"desc": "Super fast fire rate and move faster",
				"cost": 550,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 4,
			},
			3: {
				"name": "Steroids",
				"desc": "Give the tube steroids to enable it to fire 4x faster and move faster",
				"cost": 1000,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 5,
			}
		},
		3: {
			1: {
				"name": "Pebble Glue",
				"desc": "Glue deals 1 damage",
				"cost": 200,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 6,
			},
			2: {
				"name": "Rock Glue",
				"desc": "Glue deals 4 more damage and +1 piercing",
				"cost": 400,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 7,
			},
			3: {
				"name": "Boulder Glue",
				"desc": "Glue deals 8 more damage and +3 piercing",
				"cost": 800,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 8,
			}
		},
	},
	"Redwood Worker": {
		1: {
			1: {
				"name": "Stonks",
				"desc": "Gold is worth 20 more when picked up",
				"cost": 750,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 0,
			},
			2: {
				"name": "Gold NFTs",
				"desc": "Publish NFTs of the gold sprite to make 25 more cash",
				"cost": 1300,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 1,
			},
			3: {
				"name": "Lie on WallStreetBets",
				"desc": "Make WallStreetBets think Gold is valuable. Get 30 more cash",
				"cost": 1900,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 2,
			}
		},
		2: {
			1: {
				"name": "Bigger Gold Chunks",
				"desc": "Gold lasts slightly longer and is bigger",
				"cost": 600,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 3,
			},
			2: {
				"name": "Biggest Gold Chunks",
				"desc": "Enchant your pickaxe to make gold bigger and last even longer",
				"cost": 900,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 4,
			},
			3: {
				"name": "Conveyor Belts",
				"desc": "Make the gold automatically get collected",
				"cost": 1200,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 5,
			}
		},
		3: {
			1: {
				"name": "More Gold",
				"desc": "Spawn 3 more bits per wave",
				"cost": 800,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 6,
			},
			2: {
				"name": "Fortune",
				"desc": "Spawn 5 more bits per wave",
				"cost": 1400,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 7,
			},
			3: {
				"name": "Duplication Glitches",
				"desc": "Spawn 10 more bits per wave",
				"cost": 2000,
				"sprite": "redwoodworker/upgrades.png", # Location in the assets/towers
				"spriteFrame": 8,
			}
		},
	},
	"Flamethrower": {
		1: {
			1: {
				"name": "Filtered Canisters",
				"desc": "Filter cantisters to only allow pure oxygen. Fireball is larger when in contact and lasts longer",
				"cost": 700,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 0,
			},
			2: {
				"name": "Gunpowder Enfused Flame",
				"desc": "Apply gunpowder to the flame to increase size and duration",
				"cost": 1200,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 1,
			},
			3: {
				"name": "Nuclear Flame",
				"desc": "Attach a small necluar generator to the canister. A very large area of effect and deals more damage",
				"cost": 2000,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 2,
			},
		},
		2: {
			1: {
				"name": "Better Fuel Mix",
				"desc": "Create a new chemical formula to maximise efficency. Increases damage of the flame by 5",
				"cost": 800,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 3,
			},
			2: {
				"name": "Molten Liquid",
				"desc": "Infuses the flame with a molten metal to increase damage by 10",
				"cost": 1400,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 4,
			},
			3: {
				"name": "Mystic Flame",
				"desc": "Get a new mix from the heavens, increasing damage by 15",
				"cost": 2000,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 5,
			},
		},
		3: {
			1: {
				"name": "Hot Flame",
				"desc": "Increase the heat of the flame causing it to reach further. Higher detection range.",
				"cost": 600,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 6,
			},
			2: {
				"name": "Hotter Flame",
				"desc": "Apply a gel to the flame to heat it, melting of the 'Metal' status of a Perty.",
				"cost": 800,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 7,
			},
			3: {
				"name": "Hottest Flame",
				"desc": "Apply more gel, stripping of the 'Camo' status of a Perty.",
				"cost": 1250,
				"sprite": "flamethrower/upgrades.png", # Location in the assets/towers
				"spriteFrame": 8,
			},
		}
	},
	"Ruler Tower": {
		1: { # tier 1 upgrades
			1: {
				"name": "Recycling",
				"desc": "Recycle nearby litter to make more rulers allowing the use of 1 more (2).",
				"cost": 350,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 0,
			},
			2: {
				"name": "Oil Farms",
				"desc": "Make oil rig to get more oil for more rulers. Allows use of 2 more (4).",
				"cost": 700,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 1,
			},
			3: {
				"name": "Discover an Element",
				"desc": "Discover a new element and use it for the creation of rulers. Allows use of 2 more. (6)",
				"cost": 1300,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 2,
			}
		},
		2: { # tier 2 upgrades
			1: {
				"name": "Chipped Ruler",
				"desc": "Chip off ends of the ruler to increase damage and pierce",
				"cost": 400,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 3,
			},
			2: {
				"name": "Hidden Razorblade",
				"desc": "Hide a razorblade in the ruler to make it hurt more and more durable",
				"cost": 750,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 4,
			},
			3: {
				"name": "Hot Ruler",
				"desc": "Dip the ruler in a hot liquid. Has more pierce and can hit Metal pertys",
				"cost": 1200,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 5,
			}
		},
		3: { # tier 3 upgrades
			1: {
				"name": "High Range Ruler",
				"desc": "Rulers can travel further and increased tower range",
				"cost": 300,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 6,
			},
			2: {
				"name": "Turbo Ruler",
				"desc": "Expose the ruler to turbo radiation making it faster, go further and more tower range.",
				"cost": 650,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 7,
			},
			3: {
				"name": "Genetic Enhancment",
				"desc": "Change tower genetics to throw the ruler further and a lot faster.",
				"cost": 1337,
				"sprite": "ruler/upgrades.png", # Location in the assets/towers
				"spriteFrame": 8,
			}
		},
	},
}



var placing_tower = ""
var in_game = false
var max_health = 150
var starting_money = 225
var level_name = "placeholder_level_name"
var base_perty_speed = 70
var in_wave = false
var wave_number = 1
var won = false
var estimated_time_for_spawns = 1 # Redwood Worker uses this
var light_pos = Vector2.ZERO

var mouse_hover_stack_collision = 0
var mouse_hover_over_path = false
var mouse_hover_over_water = false



var perty_stages = {
	"normal": ["res://nodes/enemies/Perty.tscn", 0],
	"blue": ["res://nodes/enemies/BluePerty.tscn", 1],
	"green": ["res://nodes/enemies/GreenPerty.tscn", 2],
	"yellow": ["res://nodes/enemies/YellowPerty.tscn", 3],
	"pink": ["res://nodes/enemies/PinkPerty.tscn", 4],
	"rainbow": ["res://nodes/enemies/RainbowPerty.tscn", 5],
	}


func _ready():
	Engine.max_fps = 60 # caps at 60 because of the way the pertys move not taking fps into acount to move smoothly.


func end_game(level_difficulty, level_name, win):
	if win: # Only update achievement on win
		var current_in_array = difficultys.find(level_win[level_name])
		var new_in_array = difficultys.find(level_difficulty)
		
		if new_in_array > current_in_array:
			level_win[level_name] = level_difficulty
		
	save_data(chosen_save_file)
	
	placing_tower = ""
	in_game = false
	ticks_at_load_start = Time.get_ticks_msec()
	Engine.time_scale = 1
	get_tree().change_scene_to_file('res://nodes/menu/menu.tscn')


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
		"master_volume": master_volume,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"last_save": str(Time.get_datetime_dict_from_system()),
		"fps_cap": fps_cap,
		"vsync_mode": vsync_mode,
		"level_win": level_win,
		"window_mode": window_mode,
		"show_debug": show_debug,
		"placed_towers": placed_towers,
		"shadows_enabled": shadows_enabled,
		"shadow_level": shadow_level
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
		if "master_volume" in data: master_volume = data.master_volume
		if "music_volume" in data: music_volume = data.music_volume
		if "sfx_volume" in data: sfx_volume = data.sfx_volume
		if "fps_cap" in data: fps_cap = data.fps_cap
		if "vsync_mode" in data: vsync_mode = data.vsync_mode
		if "window_mode" in data: window_mode = data.window_mode
		if "show_debug" in data: show_debug = data.show_debug
		if "shadows_enabled" in data: shadows_enabled = data.shadows_enabled
		if "shadow_level" in data: shadow_level = data.shadow_level
		
		
		# Achievements
		# Loop through all data in level_win dict and if it exists set the value
		if "level_win" in data:
			for x in level_win:
				if x in data.level_win: level_win[x] = data.level_win[x]
		# Placed towers
		if "placed_towers" in data:
			for x in placed_towers:
				if x in data.placed_towers: placed_towers[x] = data.placed_towers[x]
		
		
		print("Loaded data from JSON")
	else:
		print("Save file not found, using default values.")
