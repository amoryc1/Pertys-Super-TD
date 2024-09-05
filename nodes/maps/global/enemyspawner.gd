extends Node2D

var enemyId = 0
var wave = 1
var waitingForBaloonPop = false
var spawningEnemy = false
var spawnCount = 0
var initwaitFinish = false
var spawning = false
var winMultiplier = 1
var wavePartID = 0

var checked_level_outcome = false
var won_level = false


func _on_gohome_pressed() -> void:
	var level_name = get_parent().levelStats[0]["levelName"]
	var level_difficulty = get_parent().levelStats[0]["difficulty"]
	GLOBALVAR_PTD.end_game(level_difficulty, level_name, won_level)

func end_game(win):
	won_level = win
	checked_level_outcome = true
	
	get_node("../summary_screen/win").visible = false
	get_node("../summary_screen/loss").visible = false
	if win: get_node("../summary_screen/win").visible = true
	else: get_node("../summary_screen/loss").visible = true
	
	get_node("../LevelUI/units/list").visible = false
	get_node("../LevelUI/startwave").disabled = true
	
	get_node("../summary_screen/AnimationPlayer").play("endlevel")

# Set HP and stuff
func _ready():
	var waveDict = get_node("..").levelStats[0]
	GLOBALVAR_PTD.max_health = waveDict["startingHealth"]
	GLOBALVAR_PTD.health = waveDict["startingHealth"]
	GLOBALVAR_PTD.level_name = waveDict["difficulty"]
	GLOBALVAR_PTD.money = waveDict["startingMoney"]
	winMultiplier  = waveDict["cashMultiplier"]
	
	var level_name = get_parent().levelStats[0]["levelName"]
	var level_difficulty = get_parent().levelStats[0]["difficulty"]
	get_node("../summary_screen/win/Label").text = "You beat " + level_name + " on " + level_difficulty + "! :D"
	get_node("../summary_screen/loss/Label").text = "You lost " + level_name + " on " + level_difficulty + "! D:"

func spawn_perty(node, status):
	var clone = load(node).instantiate()
	clone.position = get_node("../path/startzone").position
	clone.name = "ENEMY_" + str(enemyId)
	if len(status) > 0:
		for x in status:
			clone.find_child("Area2D").status.append(x)
	
	$path.add_child(clone)
	get_node("../enemytimer").start()

func _process(_delta):
	# Check for win
	if wave == len(get_node("..").levelStats) and !checked_level_outcome:
		end_game(true)
	
	if waitingForBaloonPop:
		if $path.get_child_count() == 0:
			waitingForBaloonPop = false
			GLOBALVAR_PTD.in_wave = false
			wave += 1
			GLOBALVAR_PTD.money += (10 * (wave+5)) * winMultiplier
			get_node("../LevelUI/startwave").disabled = false
			enemyId = 0

# Runs every second
func _on_enemytimer_timeout():
	if spawningEnemy:
		get_tree().root.title = get_parent().levelStats[0]["levelName"] + " / " + get_parent().levelStats[0]["difficulty"] + " / Wave " + str(wave)

		var waveArray = get_node("..").levelStats[wave]
		var x = waveArray[wavePartID]
		
		# spawn_perty(GLOBALVAR_PTD.pertyStages["blue"][0])
		# the name ('blue' in this example) is the perty name but lowercase.
		# ok this crap is gonna be really messy and glued together with a teeny amount of gum.
		
		if spawnCount == 0 and wavePartID != len(waveArray) and !spawning:
			get_node("../enemytimer").wait_time = x[2]
			spawnCount = x[1]

			spawning = true

		if spawnCount > 0 and spawning == true:
			spawn_perty(GLOBALVAR_PTD.perty_stages[x[0].to_lower()][0], x[3])
			spawnCount -= 1
		
		# Wave finished
		
		if spawnCount == 0 and wavePartID == len(waveArray)-1:
			wavePartID = 0
			waitingForBaloonPop = true
			spawningEnemy = false
			spawning = false
		elif spawnCount == 0: 
			spawning = false
			if wavePartID != len(waveArray)-1: wavePartID += 1
