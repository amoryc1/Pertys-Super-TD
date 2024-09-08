extends Area2D


@export var isTrap = false
@export var isOnWater = false
@export var waittime = 0.25
@export var cost = 25
@export var sellValue = 12
@export var projectileSpeed = 10
@export var projectilePiercing = 1
@export var projectileDamage = 1
@export var maxProjectiles = 999
@export var particleAnimated = false
@export var towerName = "Dart Tower"
@export var canUpgrade = true

var ripStatus = []

@export var canDetectCamo = false
@export var canHitLead = false

# When upgrading 3 levels appear (eg, piercing, fire rate, range)
var upgradeLevel1 = 0
var upgradeAdded1 = [false, false, false] # If upgLevelX = 1 but upgAddedX[0] = false then run the upgrade code and make it true
var upgradeLevel2 = 0
var upgradeAdded2 = [false, false, false]
var upgradeLevel3 = 0
var upgradeAdded3 = [false, false, false]

var glueLevelCount = 3

var targetlist = [] # parent = "enemyspawner"
var active = false
var isMovingFromPurchase = false

var raycast_spot_obs = false
var raycast_recent_pos = null

func check_raycast(pos: Vector2) -> bool:
	$RayCast2D.target_position = pos - global_position
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().blocks_attack:
			return true
	
	return false

func _ready():
	$waittime.wait_time = waittime

func _process(_delta): if isMovingFromPurchase:
	global_position = get_global_mouse_position()
else:
	
		if raycast_recent_pos != null:
			if raycast_recent_pos:
				raycast_spot_obs = check_raycast(raycast_recent_pos.global_position)
			
		if get_parent().name == "towers":
			$level.visible = GLOBALVAR_PTD.show_debug
			if GLOBALVAR_PTD.show_debug:
				$level.text = "[" + str(upgradeLevel1) + ", " + str(upgradeLevel2) + ", " + str(upgradeLevel3) + "]"
			
			# Glue soaks through 3 more perty layer
			if upgradeLevel1 >= 1 and upgradeAdded1[0] == false:
				glueLevelCount += 3 # 6
				upgradeAdded1[0] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][1]["cost"] * 0.75)
				$otherrotate/upgrade11.visible = true
				print("upgrade1/1")
			# Glue soaks through 5 more perty layers and reduces there speed even more
			if upgradeLevel1 >= 2 and upgradeAdded1[1] == false:
				glueLevelCount += 5 # 11
				$shootenemy.weapon = load("res://nodes/towers/particles/superglue.tscn")
				upgradeAdded1[1] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][2]["cost"] * 0.75)
				$otherrotate/upgrade12.visible = true
				print("upgrade1/2")
			#  Glue soaks through all perty layers and slows them down to 10% their normal speed
			if upgradeLevel1 >= 3 and upgradeAdded1[2] == false:
				glueLevelCount += 99999999 # should be infinite but there will probably be a bug knowing my code
				$shootenemy.weapon = load("res://nodes/towers/particles/superduperglue.tscn")
				upgradeAdded1[2] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][3]["cost"] * 0.75)
				$otherrotate/upgrade13.visible = true
				print("upgrade1/3")
			
			# Fires Glue at a faster rate and move faster
			if upgradeLevel2 >= 1 and upgradeAdded2[0] == false:
				$waittime.wait_time -= 0.2 #0.8
				projectileSpeed += 160 # 25
				upgradeAdded2[0] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][1]["cost"] * 0.75)
				$otherrotate/upgrade21.visible = true
				print("upgrade2/1")
			# Super fast fire rate and move faster
			if upgradeLevel2 >= 2 and upgradeAdded2[1] == false:
				$waittime.wait_time -= 0.2 # 0.6
				projectileSpeed += 160 # 35
				upgradeAdded2[1] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][2]["cost"] * 0.75)
				$otherrotate/upgrade22.visible = true
				print("upgrade2/2")
			# Give the tube steroids to enable it to fire 4x faster and move faster
			if upgradeLevel2 >= 3 and upgradeAdded2[2] == false:
				$waittime.wait_time -= 0.5 # 0.1
				projectileSpeed += 160 # 45
				upgradeAdded2[2] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][3]["cost"] * 0.75)
				$otherrotate/upgrade23.visible = true
				print("upgrade2/3")
			
			# Glue deals 1 damage
			if upgradeLevel3 >= 1 and upgradeAdded3[0] == false:
				projectileDamage += 1 # 1
				upgradeAdded3[0] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][1]["cost"] * 0.75)
				$otherrotate/upgrade31.visible = true
				print("upgrade3/1")
			# Glue deals 4 more damage and +1 piercing
			if upgradeLevel3 >= 2 and upgradeAdded3[1] == false:
				projectileDamage += 4 # 5
				glueLevelCount += 1 # 2 (so piercing works)
				projectilePiercing += 1 # 2 
				upgradeAdded3[1] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][2]["cost"] * 0.75)
				$otherrotate/upgrade32.visible = true
				print("upgrade3/2")
			# Glue deals 8 more damage and +3 piercing
			if upgradeLevel3 >= 3 and upgradeAdded3[2] == false:
				projectileDamage += 8 # 13
				glueLevelCount += 3 # 5 (so piercing works)
				projectilePiercing += 3 # 5 
				upgradeAdded3[2] = true
				sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][3]["cost"] * 0.75)
				$otherrotate/upgrade33.visible = true
				print("upgrade3/3")
		
		
		for x in targetlist:
			if get_node_or_null(x):
				if get_node(x).status.has("glue") or get_node(x).status.has("glue2") or get_node(x).status.has("glue3"): 
					targetlist.erase(x)


func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		var canHit = true
		if !canDetectCamo and area.status.has("camo"):canHit = false
		if !canHitLead and not area.status.has("metal"): canHit = false
		
		raycast_recent_pos = area
		raycast_spot_obs = check_raycast(raycast_recent_pos.global_position)
		if raycast_spot_obs: canHit = false
		
		if canHit:
			if not (area.status.has("glue")) and not (area.status.has("hot")):
				targetlist.append(area.get_path())

func _on_area_exited(area):
	if targetlist.has(area.get_path()):
		targetlist.erase(area.get_path())
