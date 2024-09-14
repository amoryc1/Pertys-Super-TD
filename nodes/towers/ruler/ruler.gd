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

var travelTime = .75

@export var canDetectCamo = false
@export var canHitLead = false

# When upgrading 3 levels appear (eg, piercing, fire rate, range)
var upgradeLevel1 = 0
var upgradeAdded1 = [false, false, false] # If upgLevelX = 1 but upgAddedX[0] = false then run the upgrade code and make it true
var upgradeLevel2 = 0
var upgradeAdded2 = [false, false, false]
var upgradeLevel3 = 0
var upgradeAdded3 = [false, false, false]

var hasBoomerangOn = 1 # only allow when boomerangs come back. this value has to be atleast 1
var maxBoomerangOn = 1

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
	
	$level.visible = GLOBALVAR_PTD.show_debug
	$level.text = "[" + str(upgradeLevel1) + ", " + str(upgradeLevel2) + ", " + str(upgradeLevel3) + "]"
	
	if raycast_recent_pos != null:
		if raycast_recent_pos:
			raycast_spot_obs = check_raycast(raycast_recent_pos.global_position)
		
	# Prevent a bug upgrading ALL stats
	if get_parent().name == "towers":
		# Recycle nearby litter to make more rulers allowing the use of 1 more
		if upgradeLevel1 >= 1 and upgradeAdded1[0] == false:
			$waittime.wait_time = 0.5
			upgradeAdded1[0] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][1]["cost"] * 0.75)
			$other/upgrade11.visible = true
			print("upgrade1/1")
		# Make oil rig to get more oil for more rulers. Allows use of 2 more.
		if upgradeLevel1 >= 2 and upgradeAdded1[1] == false:
			$waittime.wait_time = 0.3
			canHitLead = true
			upgradeAdded1[1] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][2]["cost"] * 0.75)
			$other/upgrade12.visible = true
			print("upgrade1/2")
		# Discover a new element and use it for the creation of rulers. Allows use of 2 more
		if upgradeLevel1 >= 3 and upgradeAdded1[2] == false:
			$waittime.wait_time = 0.2
			upgradeAdded1[2] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][1][3]["cost"] * 0.75)
			print("upgrade1/3")
		
		
		# Chip off ends of the ruler to increase damage and pierce
		if upgradeLevel2 >= 1 and upgradeAdded2[0] == false:
			projectileDamage += 1 # 2
			projectilePiercing += 3 # 6
			upgradeAdded2[0] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][1]["cost"] * 0.75)
			$otherrotate/upgrade21.visible = true
			print("upgrade2/1")
		# Hide a razorblade in the ruler to make it hurt more and more durable
		if upgradeLevel2 >= 2 and upgradeAdded2[1] == false:
			projectileDamage += 2 # 4
			projectilePiercing += 6 # 12
			upgradeAdded2[1] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][2]["cost"] * 0.75)
			print("upgrade2/2")
		# Dip the ruler in a hot liquid. Has more pierce and can hit Metal pertys
		if upgradeLevel2 >= 3 and upgradeAdded2[2] == false:
			canHitLead = true
			projectilePiercing += 12 # 24
			upgradeAdded2[2] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][2][3]["cost"] * 0.75)
			$otherrotate/upgrade23.visible = true
			print("upgrade2/3")
		
		# Rulers can travel further and increased tower range
		if upgradeLevel3 >= 1 and upgradeAdded3[0] == false:
			$CollisionShape2D.shape.radius += 30 #230
			$ring.scale += Vector2(0.225, 0.225)
			travelTime += .2
			upgradeAdded3[0] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][1]["cost"] * 0.75)
			print("upgrade3/1")
		# Expose the ruler to turbo radiation making it faster, go further and more tower range
		if upgradeLevel3 >= 2 and upgradeAdded3[1] == false:
			$CollisionShape2D.shape.radius += 30 #230
			$ring.scale += Vector2(0.225, 0.225)
			projectileSpeed += 64 # 10
			upgradeAdded3[1] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][2]["cost"] * 0.75)
			$otherrotate/upgrade32.visible = true
			print("upgrade3/2")
		# Change tower genetics to throw the ruler further and a lot faster
		if upgradeLevel3 >= 3 and upgradeAdded3[2] == false:
			$CollisionShape2D.shape.radius += 30 #230
			$ring.scale += Vector2(0.225, 0.225)
			projectileSpeed += 160 # 15
			travelTime += .3
			upgradeAdded3[2] = true
			sellValue += int(GLOBALVAR_PTD.tower_upgrades[towerName][3][3]["cost"] * 0.75)
			$otherrotate/upgrade33.visible = true
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
