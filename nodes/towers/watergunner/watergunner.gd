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
var active = false
var isMovingFromPurchase = false
func _ready():
	$waittime.wait_time = waittime
	
	$other/floatie.self_modulate = Color8(randi_range(0,255),randi_range(0,255),randi_range(0,255))

func _process(_delta): if isMovingFromPurchase:
	global_position = get_global_mouse_position()
else:
	$level.visible = GLOBALVAR_PTD.show_debug
	$level.text = "[" + str(upgradeLevel1) + ", " + str(upgradeLevel2) + ", " + str(upgradeLevel3) + "]"
	
	
	# Prevent a bug upgrading ALL stats
	if get_parent().name == "towers":
		# Find a new pistol made of better plastic to increase range and projectile speed
		if upgradeLevel1 >= 1 and upgradeAdded1[0] == false:
			$ring.scale += Vector2(.25, .25)
			$CollisionShape2D.shape.radius += 30
			projectileSpeed += 100
			upgradeAdded1[0] = true
			sellValue += int(300 * 0.75)
			print("upgrade1/1")
		# Presses on the trigger lighter to make water go further and faster... somehow
		if upgradeLevel1 >= 2 and upgradeAdded1[1] == false:
			$ring.scale += Vector2(.25, .25)
			$CollisionShape2D.shape.radius += 30
			projectileSpeed += 100
			upgradeAdded1[1] = true
			sellValue += int(600 * 0.75)
			print("upgrade1/2")
		# Reinforce the frame with steel, making water go faster and further
		if upgradeLevel1 >= 3 and upgradeAdded1[2] == false:
			$ring.scale += Vector2(.25, .25)
			$CollisionShape2D.shape.radius += 30
			projectileSpeed += 150
			ripStatus.append("fire")
			upgradeAdded1[2] = true
			sellValue += int(900 * 0.75)
			print("upgrade1/3")
		
		
		# default - 140px, 2.2x radius
		# More capacity to allow for less time between shots
		if upgradeLevel2 >= 1 and upgradeAdded2[0] == false:
			$waittime.wait_time -= 0.1 # 0.4
			upgradeAdded2[0] = true
			sellValue += int(425 * 0.75)
			print("upgrade2/1")
		# Increase pressure in the pistol to fire it faster
		if upgradeLevel2 >= 2 and upgradeAdded2[1] == false:
			$waittime.wait_time -= 0.15 # 0.25
			upgradeAdded2[1] = true
			sellValue += int(650 * 0.75)
			print("upgrade2/2")
		# Mod the pistol to automate firing further decreasing wait times
		if upgradeLevel2 >= 3 and upgradeAdded2[2] == false:
			$waittime.wait_time -= 0.15 # 0.1
			upgradeAdded2[2] = true
			sellValue += int(1100 * 0.75)
			print("upgrade2/3")
		
		# Condense water to hurt more and have pierce multiple enemies
		if upgradeLevel3 >= 1 and upgradeAdded3[0] == false:
			projectileDamage += 1
			projectilePiercing += 2
			upgradeAdded3[0] = true
			sellValue += int(450 * 0.75)
			print("upgrade3/1")
		# Embue your water with acid to deal more damage and pierce more enemies
		if upgradeLevel3 >= 2 and upgradeAdded3[1] == false:
			projectileDamage += 2
			projectilePiercing += 2
			upgradeAdded3[1] = true
			sellValue += int(700 * 0.75)
			print("upgrade3/2")
		# Use lava instead of water to deal more damage and piercing
		if upgradeLevel3 >= 3 and upgradeAdded3[2] == false:
			projectileDamage += 3
			projectilePiercing += 2
			upgradeAdded3[2] = true
			sellValue += int(1300 * 0.75)
			print("upgrade3/3")





func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		var canHit = true
		if !canDetectCamo and area.status.has("camo"): canHit = false
		elif !canHitLead and area.status.has("metal"): canHit = false
		
		if canHit: 
			targetlist.append(area.get_path())

func _on_area_exited(area):
	if targetlist.has(area.get_path()):
		targetlist.erase(area.get_path())
