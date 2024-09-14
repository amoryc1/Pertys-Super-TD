extends Node


var game_version = "[beta 0.13] - 2024-09-14"

var ticks_at_load_start = 0

var money = 0
var total_money = 0
var health = 100
var exp = 0
var total_exp = 0
var level = 1

var has_loaded_data = false
var show_exp_bar = true

var hide_user = false
var file_format_ver = 1
var chosen_save_file = "saves/SaveFile1"
var screenshot_folder = "screenshots"
var show_debug = false
var fps_cap = 60
var vsync_mode = "Enabled"
var window_mode = "Windowed"
var music_volume = 1
var sfx_volume = 1
var master_volume = 1
var level_win = { 
	# Difficulty Won, [[wave, money, life, current difficulty], ["tower name", pos, upgrades], ["tower name", pos, upgrades]]
	"The Park": [{"Easy":0,"Normal":0,"Hard":0,"Hardcore":0}, {}]
}
var shadows_enabled = true
var shadow_level = "pcf5"



var difficultys = ["Easy","Normal","Hard","Hardcore"]


var placed_towers = {
	"Pencil Tower": 0,
	"Gabby's Book": 0,
	"Glue Gunner": 0,
	"Redwood Worker": 0,
	"Flamethrower": 0,
	"Ruler Tower": 0,
	"Watergunner": 0,
	"Airplane Sniper": 0,
}

var tower_nodes = { # Path inside of res://nodes/towers/
	"Pencil Tower": "dart/darttower",
	"Gabby's Book": "particles/spikes",
	"Glue Gunner": "glue/gluetower",
	"Redwood Worker": "redwoodworker/worker",
	"Flamethrower": "flamethrower/flamethrower",
	"Ruler Tower": "ruler/ruler",
	"Watergunner": "watergunner/watergunner",
	"Airplane Sniper": "airplanesniper/airplanesniper",
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
				"desc": "Glue soaks through 5 more perty layers and reduces their speed to 50%",
				"cost": 800,
				"sprite": "glue/upgrades.png", # Location in the assets/towers
				"spriteFrame": 1,
			},
			3: {
				"name": "Omega Glue",
				"desc": "Glue soaks through all perty layers and slows them down to 33% their normal speed",
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
	"Watergunner": {
		1: { # tier 1 upgrades
			1: {
				"name": "Better Plastic",
				"desc": "Find a new pistol made of better plastic to increase range and projectile speed",
				"cost": 300,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 0,
			},
			2: {
				"name": "Lighter Trigger",
				"desc": "Presses on the trigger lighter to make water go further and faster... somehow",
				"cost": 600,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 1,
			},
			3: {
				"name": "Reinforced Frame",
				"desc": "Reinforce the frame with steel, making water go faster and further and can remove 'Fire' status",
				"cost": 900,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 2,
			}
		},
		2: { # tier 2 upgrades
			1: {
				"name": "Increased Capacity",
				"desc": "More capacity to allow for less time between shots",
				"cost": 425,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 3,
			},
			2: {
				"name": "High Pressure",
				"desc": "Increase pressure in the pistol to fire it faster",
				"cost": 650,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 4,
			},
			3: {
				"name": "Automatic Pistol",
				"desc": "Mod the pistol to automate firing further decreasing wait times",
				"cost": 1100,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 5,
			}
		},
		3: { # tier 3 upgrades
			1: {
				"name": "Condensed Water",
				"desc": "Condense water to hurt more and have pierce multiple enemies",
				"cost": 450,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 6,
			},
			2: {
				"name": "Acid Water",
				"desc": "Embue your water with acid to deal more damage and pierce more enemies",
				"cost": 700,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 7,
			},
			3: {
				"name": "Lava Pistol",
				"desc": "Use lava instead of water to deal more damage and piercing",
				"cost": 1300,
				"sprite": "watergunner/upgrades.png", # Location in the assets/towers
				"spriteFrame": 8,
			}
		},
	},
	"Airplane Sniper": {
		1: { # tier 1 upgrades
			1: {
				"name": "Infrared Goggles",
				"desc": "Put on some goggles to detect camo enemies",
				"cost": 450,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 0,
			},
			2: {
				"name": "Improved Accuracy",
				"desc": "Thrown Paper Airplanes travel quicker",
				"cost": 425,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 1,
			},
			3: {
				"name": "Trickshot",
				"desc": "Thrown Paper Airplanes travel even faster and are thrown more frequently",
				"cost": 800,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 2,
			}
		},
		2: { # tier 2 upgrades
			1: {
				"name": "Sharp Edges",
				"desc": "Paper Airplanes gain +1 pierce and +2 damage",
				"cost": 400,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 3,
			},
			2: {
				"name": "Larger Sheets",
				"desc": "Use larger sheets of paper to increase the Airplanes size and pierce",
				"cost": 600,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 4,
			},
			3: {
				"name": "Explosive Tip",
				"desc": "Small explosion on impact dealing 1 damage to the effected enemies",
				"cost": 1300,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 5,
			}
		},
		3: { # tier 3 upgrades
			1: {
				"name": "Fast Throwing",
				"desc": "Throw more frequently",
				"cost": 450,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 6,
			},
			2: {
				"name": "Even Faster Throwing",
				"desc": "Throw even more frequently",
				"cost": 700,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 7,
			},
			3: {
				"name": "Crazy Fast Throwing",
				"desc": "Throw Paper Airplanes incredibly fast",
				"cost": 1300,
				"sprite": "airplanesniper/upgrades.png", # Location in the assets/towers
				"spriteFrame": 8,
			}
		},
	}
}

var map_nodes = {
	"The Park": {
		"Easy": "res://nodes/maps/testmap/main.tscn"
	}
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
	"foap": ["res://nodes/enemies/FOAP.tscn", 7],
	}


func calculate_xp_for_levelup():
	if level == 1: return 5
	else: return int((10 * level) + (level ** 1.75))


func end_game(level_difficulty, level_name, win, exp_reward):
	if win: # Add 1 to difficulty count
		if level_win[level_name][0][level_difficulty] == 0: # 100% xp on first win
			exp += exp_reward
			total_exp += exp_reward
		else: # 50% xp on wins after
			exp += exp_reward * 0.5
			total_exp += exp_reward * 0.5
		level_win[level_name][0][level_difficulty] += 1
		
	
	level_win[level_name][1].erase(level_difficulty) # Erase progress on win/loss/deletion
	
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


func _ready() -> void:
	var dir1 = DirAccess.open("user://saves")
	if dir1 == null:
		DirAccess.make_dir_absolute("user://saves")
	
	var dir2 = DirAccess.open("user://screenshots")
	if dir2 == null:
		DirAccess.make_dir_absolute("user://screenshots")
	
	var dir3 = DirAccess.open("user://levels")
	if dir3 == null:
		DirAccess.make_dir_absolute("user://levels")


# I want to marry ChatGPT thank you so much for this pookie <3

func save_data(filename):
	var dir = DirAccess.open("user://saves")
	if dir == null:
		DirAccess.make_dir_absolute("user://saves")
	
	var savePath = "user://" + str(filename) + ".json"
	
	var data = {
		"master_volume": master_volume,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"game_version": game_version,
		"fps_cap": fps_cap,
		"vsync_mode": vsync_mode,
		"level_win": level_win,
		"window_mode": window_mode,
		"show_debug": show_debug,
		"placed_towers": placed_towers,
		"shadows_enabled": shadows_enabled,
		"shadow_level": shadow_level,
		"file_format_ver": file_format_ver,
		"hide_user": hide_user,
		"total_money": total_money,
		"total_exp": total_exp,
		"exp": exp,
		"level": level
	}
	
	var json_string = JSON.stringify(data)
	
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
		if hide_user:
			print("Successfully saved data as JSON. Path: ", file.get_path())
			return [true, file.get_path()]
		else:
			print("Successfully saved data as JSON. Path: ", file.get_path_absolute())
			return [true, file.get_path_absolute()]
	else:
		print("Failed to open save file for writing.")
		return [false]

func load_data(filename):
	var savePath = "user://" + str(filename) + ".json"
	
	var dir = DirAccess.open("user://saves")
	if dir == null:
		DirAccess.make_dir_absolute("user://saves")
	
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
		if "file_format_ver" in data: file_format_ver = data.file_format_ver
		if "hide_user" in data: hide_user = data.hide_user
		if "total_money" in data: total_money = data.total_money
		if "exp" in data: exp = data.exp
		if "total_exp" in data: total_exp = data.total_exp
		if "level" in data: level = data.level
		
		
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
