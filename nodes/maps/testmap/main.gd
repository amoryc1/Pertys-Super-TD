extends Node2D

# FORMAT
#
# First thing in array will be a dictionary, this holds basic stuff like the name, starting cash etc
# After that are arrays which hold information based on waves
#
# [
#		{"difficulty", "startingHealth", "startingMoney", "cashMultiplier"}
# 		[pertyType (str), spawnAmount (int), time per spawn (flt), status (array [])],
# 		repeat for x amount of unique spawns
# ]

# "events" will hold what happens at the start/end of a certain wave. example: 
#			2: [false, "speech", "This is Wave 2!"]
# The false is for if it occurs at the end. true - event occurs at wave end, false - event occurs at wave start 
# When wave 2 starts a little message will appear with "This is Wave 2!"

var levelStats =[{ "levelName": "The Park", "difficulty": "Easy", "startingHealth": 5, "startingMoney": 1500, "cashMultiplier": 1, "expReward": 10, "events": {  } }, [["Normal", 1, 0.1, []], ["Blue", 1, 0.1, []], ["Green", 1, 0.1, []], ["Yellow", 1, 0.1, []], ["Pink", 1, 0.1, []], ["Rainbow", 1, 0.1, []]], [["Rainbow", 1, 0.1, []]], [["Foap", 2, 0.1, []]], [["Normal", 1000, 0.02, []]]]



func _ready() -> void:
	# Check sun pos for shaders
	GLOBALVAR_PTD.light_pos = $sun.global_position
	
	$sun.shadow_enabled = GLOBALVAR_PTD.shadows_enabled
	if GLOBALVAR_PTD.shadow_level == "none":$sun.shadow_filter = PointLight2D.SHADOW_FILTER_NONE
	elif GLOBALVAR_PTD.shadow_level == "pcf5":$sun.shadow_filter = PointLight2D.SHADOW_FILTER_PCF5
	elif GLOBALVAR_PTD.shadow_level == "pcf13":$sun.shadow_filter = PointLight2D.SHADOW_FILTER_PCF13
