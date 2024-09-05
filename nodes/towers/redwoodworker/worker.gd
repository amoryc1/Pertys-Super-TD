extends Area2D


@export var isTrap = false
@export var isOnWater = false
@export var waitTime = 3
@export var spawnCount = 3
@export var cost = 25
@export var sellValue = 12
@export var towerName = "Dart Tower"
@export var goldValue = 20
@export var canUpgrade = true

# When upgrading 3 levels appear (eg, piercing, fire rate, range)
var upgradeLevel1 = 0
var upgradeAdded1 = [false, false, false] # If upgLevelX = 1 but upgAddedX[0] = false then run the upgrade code and make it true
var upgradeLevel2 = 0
var upgradeAdded2 = [false, false, false]
var upgradeLevel3 = 0
var upgradeAdded3 = [false, false, false]

var targetlist = [] # parent = "enemyspawner"
var active = false
var isMovingFromPurchase = false
var spawnsThisWave = 0
var goldTime = 5 # How long gold stays up
var goldSize = Vector2(1, 1)
var autoCollectMode = false

func _process(_delta): 
	if isMovingFromPurchase:
		global_position = get_global_mouse_position()
	else:
		$level.visible = GLOBALVAR_PTD.show_debug
		if GLOBALVAR_PTD.show_debug:
			$level.text = "[" + str(upgradeLevel1) + ", " + str(upgradeLevel2) + ", " + str(upgradeLevel3) + "]"
		
		# Gold is worth 20 more when picked up
		if upgradeLevel1 >= 1 and upgradeAdded1[0] == false:
			goldValue += 20 # 40
			upgradeAdded1[0] = true
			sellValue += int(750 * 0.75)
			print("upgrade1/1")
		# Publish NFTs of the gold sprite to make 25 more cash
		if upgradeLevel1 >= 2 and upgradeAdded1[1] == false:
			goldValue += 25 # 65
			upgradeAdded1[1] = true
			sellValue += int(1300 * 0.75)
			print("upgrade1/2")
		# Make WallStreetBets think Gold is worth it. Get 30 more cash
		if upgradeLevel1 >= 3 and upgradeAdded1[2] == false:
			goldValue += 30 # 95
			upgradeAdded1[2] = true
			sellValue += int(1900 * 0.75)
			print("upgrade1/3")
		
		# Gold lasts slightly longer and is bigger
		if upgradeLevel2 >= 1 and upgradeAdded2[0] == false:
			goldTime += 2 #7
			goldSize += Vector2(0.5, 0.5) # 1.5, 1.5
			upgradeAdded2[0] = true
			sellValue += int(600 * 0.75)
			print("upgrade2/1")
		# Enchant your pickaxe to make gold bigger and last even longer
		if upgradeLevel2 >= 2 and upgradeAdded2[1] == false:
			goldTime += 3 # 10
			goldSize += Vector2(1, 1) # 2.5, 2.5
			upgradeAdded2[1] = true
			sellValue += int(900 * 0.75)
			print("upgrade2/2")
		# Make the gold automatically get collected
		if upgradeLevel2 >= 3 and upgradeAdded2[2] == false:
			autoCollectMode = true
			upgradeAdded2[2] = true
			sellValue += int(1200 * 0.75)
			print("upgrade2/3")
		
		# Spawn 3 more bits per wave
		if upgradeLevel3 >= 1 and upgradeAdded3[0] == false:
			spawnCount += 3 # 6
			upgradeAdded3[0] = true
			sellValue += int(800 * 0.75)
			print("upgrade3/1")
		# Spawn 5 more bits per wave
		if upgradeLevel3 >= 2 and upgradeAdded3[1] == false:
			spawnCount += 5 # 11
			upgradeAdded3[1] = true
			sellValue += int(1400 * 0.75)
			print("upgrade3/2")
		# Spawn 10 more bits per wave
		if upgradeLevel3 >= 3 and upgradeAdded3[2] == false:
			spawnCount += 10 # 16
			upgradeAdded3[2] = true
			sellValue += int(2000 * 0.75)
			print("upgrade3/3")
		
		
		
		
		if get_parent().name == "towers":
			pass
	
	
	if active and get_node("../../enemyspawner").spawningEnemy:
		if $waittime.time_left == 0:
			$waittime.wait_time = GLOBALVAR_PTD.estimated_time_for_spawns / spawnCount
			$waittime.start()
	else: 
		
		spawnsThisWave = 0
		$waittime.stop()

func _on_waittime_timeout():
	if spawnsThisWave < spawnCount:
		var randomDir = Vector2(randf(), randf()) * 50
		$sprite.play("default")
		
		var goldClone = load("res://nodes/towers/particles/gold.tscn").instantiate()
		goldClone.position = global_position + randomDir
		goldClone.name = "goldBit"
		goldClone.goldValue = goldValue
		goldClone.find_child("Sprite2D").scale = goldSize
		goldClone.autoCollect = autoCollectMode
		
		goldClone.find_child("Timer").wait_time = goldTime
		get_node("../").add_child(goldClone)
		
		spawnsThisWave += 1
