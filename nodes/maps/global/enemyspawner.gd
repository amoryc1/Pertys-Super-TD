extends Node2D

var isBoss = false
var bossMusic = preload("res://music/boss/Battle Mage.ogg")

var enemyId = 0
var wave = 1
var waitingForBaloonPop = false
var spawningEnemy = false
var spawnCount = 0
var initwaitFinish = false
var spawning = false
var winMultiplier = 1
var wavePartID = 0

# Set HP and stuff
func _ready():
	var waveDict = get_node("..").levelStats[0]
	GLOBALVAR_PTD.maxHealth = waveDict["startingHealth"]
	GLOBALVAR_PTD.health = waveDict["startingHealth"]
	GLOBALVAR_PTD.levelName = waveDict["difficulty"]
	GLOBALVAR_PTD.money = waveDict["startingMoney"]
	winMultiplier  = waveDict["cashMultiplier"]

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
	get_node("../pertysOnScreen").text = "Current Perty Count: " + str($path.get_child_count())
	GLOBALVAR_PTD.waveNumber = wave
	
	# Check for win
	if wave == len(get_node("..").levelStats):
		GLOBALVAR_PTD.win_game(get_parent().levelStats[0]["difficulty"], get_parent().levelStats[0]["levelName"])
	
	if waitingForBaloonPop:
		if $path.get_child_count() == 0:
			waitingForBaloonPop = false
			GLOBALVAR_PTD.inWave = false
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
			spawn_perty(GLOBALVAR_PTD.pertyStages[x[0].to_lower()][0], x[3])
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
	
	# Change music if a boss is on screen
	if isBoss and get_node("../BGM").stream != bossMusic:
		get_node("../BGM").stream = bossMusic
		get_node("../BGM").play()
