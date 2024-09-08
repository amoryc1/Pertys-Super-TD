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


var targetlist = [] # parent = "enemyspawner"
@export var active = false
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
	$sprite/camo.frame = randi_range(0,4)

func _process(_delta): if isMovingFromPurchase:
	global_position = get_global_mouse_position()
else:
	$level.visible = GLOBALVAR_PTD.show_debug
	$level.text = "[" + str(upgradeLevel1) + ", " + str(upgradeLevel2) + ", " + str(upgradeLevel3) + "]"
	
	if raycast_recent_pos != null:
		if raycast_recent_pos:
			raycast_spot_obs = check_raycast(raycast_recent_pos.global_position)
	
	# Prevent a bug upgrading ALL stats
	if get_parent().name == "towers":
		# Put on some goggles to detect camo enemies
		if upgradeLevel1 >= 1 and upgradeAdded1[0] == false:
			canDetectCamo = true
			
			upgradeAdded1[0] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][1]["cost"] * 0.75)
			$otherrotate/upgrade11.visible = true
			print("upgrade1/1")
		# Thrown Paper Airplanes travel quicker
		if upgradeLevel1 >= 2 and upgradeAdded1[1] == false:
			projectileSpeed += 200
			
			upgradeAdded1[1] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][2]["cost"] * 0.75)
			$otherrotate/upgrade12.visible = true
			print("upgrade1/2")
		# Thrown Paper Airplanes travel even faster more frequently
		if upgradeLevel1 >= 3 and upgradeAdded1[2] == false:
			projectileSpeed += 300
			$waittime.wait_time -= 0.3
			
			upgradeAdded1[2] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][3]["cost"] * 0.75)
			print("upgrade1/3")
		
		
		# IPaper Airplanes gain +1 pierce and +1 damage
		if upgradeLevel2 >= 1 and upgradeAdded2[0] == false:
			projectilePiercing += 1
			projectileDamage += 2
			
			upgradeAdded2[0] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][1]["cost"] * 0.75)
			print("upgrade2/1")
		# Use larger sheets of paper to increase the Airplanes size and pierce
		if upgradeLevel2 >= 2 and upgradeAdded2[1] == false:
			projectilePiercing += 2
			# Inc proj size by 1.6x
			
			upgradeAdded2[1] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][2]["cost"] * 0.75)
			print("upgrade2/2")
		# Small explosion on impact dealing 1 damage to the effected enemies
		if upgradeLevel2 >= 3 and upgradeAdded2[2] == false:
			projectileDamage += 2
			
			upgradeAdded2[2] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][3]["cost"] * 0.75)
			print("upgrade2/3")
		
		# Throw more frequently
		if upgradeLevel3 >= 1 and upgradeAdded3[0] == false:
			$waittime.wait_time -= 0.25
			
			upgradeAdded3[0] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][1]["cost"] * 0.75)
			print("upgrade3/1")
		# Throw even more frequently
		if upgradeLevel3 >= 2 and upgradeAdded3[1] == false:
			$waittime.wait_time -= 0.4
			
			upgradeAdded3[1] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][2]["cost"] * 0.75)
			print("upgrade3/2")
		# Throw Paper Airplanes incredibly fast
		if upgradeLevel3 >= 3 and upgradeAdded3[2] == false:
			$waittime.wait_time -= 0.5
			
			upgradeAdded3[2] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][3]["cost"] * 0.75)
			print("upgrade3/3")





func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		var canHit = true
		if !canDetectCamo and area.status.has("camo"): canHit = false
		elif !canHitLead and area.status.has("metal"): canHit = false
		
		raycast_recent_pos = area
		raycast_spot_obs = check_raycast(raycast_recent_pos.global_position)
		if raycast_spot_obs: canHit = false
		
		if canHit:
			targetlist.append(area.get_path())

func _on_area_exited(area):
	if targetlist.has(area.get_path()):
		targetlist.erase(area.get_path())
