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

func _process(_delta): if isMovingFromPurchase:
	global_position = get_global_mouse_position()
else:
	$level.visible = GLOBALVAR_PTD.show_debug
	$level.text = "[" + str(upgradeLevel1) + ", " + str(upgradeLevel2) + ", " + str(upgradeLevel3) + "]"
	
	
	# Prevent a bug upgrading ALL stats
	if get_parent().name == "towers":
		# Pencils thrown by this tower can pierce 2 more Pertys
		if upgradeLevel1 >= 1 and upgradeAdded1[0] == false:
			projectilePiercing += 2 # 3
			upgradeAdded1[0] = true
			sellValue += int(175 * 0.75)
			print("upgrade1/1")
		# Can pierce 4 more Pertys and can pop Metal Pertys. Does 3 more damage
		if upgradeLevel1 >= 2 and upgradeAdded1[1] == false:
			projectilePiercing += 4 # 7
			projectileDamage += 3 #4
			canHitLead = true
			upgradeAdded1[1] = true
			sellValue += int(525 * 0.75)
			print("upgrade1/2")
		# Pierces 15 Pertys and does 6 more damage
		if upgradeLevel1 >= 3 and upgradeAdded1[2] == false:
			projectilePiercing += 15 # 22
			projectileDamage += 6 # 10
			upgradeAdded1[2] = true
			sellValue += int(1450 * 0.75)
			print("upgrade1/3")
		
		
		# default - 140px, 2.2x radius
		# Increases the range this tower can spot Pertys
		if upgradeLevel2 >= 1 and upgradeAdded2[0] == false:
			$CollisionShape2D.shape.radius += 40 # 180
			$ring.scale += Vector2(.3, .3) # 2.8, 2.8
			upgradeAdded2[0] = true
			sellValue += int(125 * 0.75)
			print("upgrade2/1")
		# Even more range and can see camo Pertys
		if upgradeLevel2 >= 2 and upgradeAdded2[1] == false:
			$CollisionShape2D.shape.radius += 40 # 220
			$ring.scale += Vector2(.3, .3) # 3.4, 3.4
			canDetectCamo = true
			upgradeAdded2[1] = true
			sellValue += int(420 * 0.75)
			print("upgrade2/2")
		# A ton more range. Thrown pencils also move slightly faster
		if upgradeLevel2 >= 3 and upgradeAdded2[2] == false:
			$CollisionShape2D.shape.radius += 60 # 280
			$ring.scale += Vector2(.45, .45) # 4.3, 4.3
			projectileSpeed += 48
			upgradeAdded2[2] = true
			sellValue += int(800 * 0.75)
			print("upgrade2/3")
		
		# Throws pencils quicker and more frequently
		if upgradeLevel3 >= 1 and upgradeAdded3[0] == false:
			projectileSpeed += 32 # 22
			$waittime.wait_time -= 0.25 # 0.5
			upgradeAdded3[0] = true
			sellValue += int(130 * 0.75)
			print("upgrade3/1")
		# Using a robot arm, this tower can throw pencils super duper fast and make new pencils super quick
		if upgradeLevel3 >= 2 and upgradeAdded3[1] == false:
			projectileSpeed += 80 # 27
			$waittime.wait_time -= 0.25 # 0.25
			upgradeAdded3[1] = true
			sellValue += int(540 * 0.75)
			print("upgrade3/2")
		# Throws an RPP instead of a pencil which are extremely fast. Also deals more damage since they are that fast
		if upgradeLevel3 >= 3 and upgradeAdded3[2] == false:
			projectileSpeed += 80 # 32
			projectileDamage += 2 # 3
			canHitLead = true
			upgradeAdded3[2] = true
			sellValue += int(1400 * 0.75)
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
