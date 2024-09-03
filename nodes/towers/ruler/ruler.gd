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

var travelTime = .5

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
func _ready():
	$waittime.wait_time = waittime

func _process(_delta): if isMovingFromPurchase:
	global_position = get_global_mouse_position()
else:
	
	$level.visible = GLOBALVAR_PTD.showDebug
	$level.text = "[" + str(upgradeLevel1) + ", " + str(upgradeLevel2) + ", " + str(upgradeLevel3) + "]"
	
	
	# Prevent a bug upgrading ALL stats
	if get_parent().name == "towers":
		# Recycle nearby litter to make more rulers allowing the use of 1 more
		if upgradeLevel1 >= 1 and upgradeAdded1[0] == false:
			maxBoomerangOn += 1 # 2
			hasBoomerangOn += 1 # 2
			$waittime.wait_time = 0.5
			upgradeAdded1[0] = true
			sellValue += int(350 * 0.75)
			print("upgrade1/1")
		# Make oil rig to get more oil for more rulers. Allows use of 2 more.
		if upgradeLevel1 >= 2 and upgradeAdded1[1] == false:
			maxBoomerangOn += 2 # 4
			hasBoomerangOn += 2 # 4
			$waittime.wait_time = 0.25
			canHitLead = true
			upgradeAdded1[1] = true
			sellValue += int(700 * 0.75)
			print("upgrade1/2")
		# Discover a new element and use it for the creation of rulers. Allows use of 4 more
		if upgradeLevel1 >= 3 and upgradeAdded1[2] == false:
			maxBoomerangOn += 4 # 8
			hasBoomerangOn += 4 # 8
			maxProjectiles += 4 # 8
			$waittime.wait_time = 0.135
			upgradeAdded1[2] = true
			sellValue += int(1300 * 0.75)
			print("upgrade1/3")
		
		
		# Chip off ends of the ruler to increase damage and pierce
		if upgradeLevel2 >= 1 and upgradeAdded2[0] == false:
			projectileDamage += 1 # 2
			projectilePiercing += 3 # 6
			upgradeAdded2[0] = true
			sellValue += int(400 * 0.75)
			print("upgrade2/1")
		# Hide a razorblade in the ruler to make it hurt more and more durable
		if upgradeLevel2 >= 2 and upgradeAdded2[1] == false:
			projectileDamage += 2 # 4
			projectilePiercing += 6 # 12
			upgradeAdded2[1] = true
			sellValue += int(750 * 0.75)
			print("upgrade2/2")
		# Dip the ruler in a hot liquid. Has more pierce and can hit Metal pertys
		if upgradeLevel2 >= 3 and upgradeAdded2[2] == false:
			canHitLead = true
			projectilePiercing += 12 # 24
			upgradeAdded2[2] = true
			sellValue += int(1200 * 0.75)
			print("upgrade2/3")
		
		# Rulers can travel further and increased tower range
		if upgradeLevel3 >= 1 and upgradeAdded3[0] == false:
			$CollisionShape2D.shape.radius += 30 #230
			$ring.scale += Vector2(0.225, 0.225)
			travelTime += .1
			upgradeAdded3[0] = true
			sellValue += int(300 * 0.75)
			print("upgrade3/1")
		# Expose the ruler to turbo radiation making it faster, go further and more tower range
		if upgradeLevel3 >= 2 and upgradeAdded3[1] == false:
			$CollisionShape2D.shape.radius += 30 #230
			$ring.scale += Vector2(0.225, 0.225)
			projectileSpeed += 2 # 10
			upgradeAdded3[1] = true
			sellValue += int(650 * 0.75)
			print("upgrade3/2")
		# Change tower genetics to throw the ruler further and a lot faster
		if upgradeLevel3 >= 3 and upgradeAdded3[2] == false:
			$CollisionShape2D.shape.radius += 30 #230
			$ring.scale += Vector2(0.225, 0.225)
			projectileSpeed += 5 # 15
			travelTime += .2
			upgradeAdded3[2] = true
			sellValue += int(1337 * 0.75)
			print("upgrade3/3")





func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		var canHit = true
		if !canDetectCamo and area.status.has("camo"): canHit = false
		elif !canHitLead and area.status.has("metal"): canHit = false
		
		if canHit and hasBoomerangOn > 0: 
			hasBoomerangOn -= 1
			targetlist.append(area.get_path())

func _on_area_exited(area):
	if targetlist.has(area.get_path()):
		targetlist.erase(area.get_path())
