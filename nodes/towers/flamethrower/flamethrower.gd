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
@export var canDetectCamo = false
@export var canHitLead = false

var ripStatus = []

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
	if GLOBALVAR_PTD.show_debug:
		$level.text = "[" + str(upgradeLevel1) + ", " + str(upgradeLevel2) + ", " + str(upgradeLevel3) + "]"
	
	# Prevent a bug upgrading ALL stats
	if get_parent().name == "towers":
		# lter cantisters to only allow pure oxygen. Fireball is larger when in contact and lasts longer
		if upgradeLevel1 >= 1 and upgradeAdded1[0] == false:
			upgradeAdded1[0] = true
			sellValue += int(700 * 0.75)
			print("upgrade1/1")
		# Apply gunpowder to the flame to increase size and duration
		if upgradeLevel1 >= 2 and upgradeAdded1[1] == false:
			canHitLead = true
			upgradeAdded1[1] = true
			sellValue += int(1200 * 0.75)
			print("upgrade1/2")
		# Attach a small necluar generator to the canister. A very large area of effect and deals more damage
		if upgradeLevel1 >= 3 and upgradeAdded1[2] == false:
			$shootenemy.weapon = load("res://nodes/towers/particles/firewall4.tscn")
			projectileDamage += 2 # 5
			upgradeAdded1[2] = true
			sellValue += int(2000 * 0.75)
			print("upgrade1/3")
		
		
		# Create a new chemical formula to maximise efficency. Increases damage of the flame by 5
		if upgradeLevel2 >= 1 and upgradeAdded2[0] == false:
			projectileDamage += 5 # 8
			upgradeAdded2[0] = true
			sellValue += int(800 * 0.75)
			print("upgrade2/1")
		# Infuses the flame with a molten metal to increase damage by 10
		if upgradeLevel2 >= 2 and upgradeAdded2[1] == false:
			projectileDamage += 10 # 18
			upgradeAdded2[1] = true
			sellValue += int(1400 * 0.75)
			print("upgrade2/2")
		# Get a new mix from the heavens, increasing damage by 15
		if upgradeLevel2 >= 3 and upgradeAdded2[2] == false:
			projectileDamage += 15 # 33
			upgradeAdded2[2] = true
			sellValue += int(2000 * 0.75)
			print("upgrade2/3")
		
		# Increase the heat of the flame causing it to reach further. Higher detection range
		if upgradeLevel3 >= 1 and upgradeAdded3[0] == false:
			$CollisionShape2D.shape.radius += 60
			$ring.scale += Vector2(0.95, 0.95)
			upgradeAdded3[0] = true
			sellValue += int(600 * 0.75)
			print("upgrade3/1")
		# Apply a gel to the flame to heat it, melting of the 'Metal' status of a Perty.
		if upgradeLevel3 >= 2 and upgradeAdded3[1] == false:
			ripStatus.append("metal")
			upgradeAdded3[1] = true
			sellValue += int(800 * 0.75)
			print("upgrade3/2")
		# Apply more gel, stripping of the 'Camo' status of a Perty.
		if upgradeLevel3 >= 3 and upgradeAdded3[2] == false:
			ripStatus.append("camo")
			upgradeAdded3[2] = true
			sellValue += int(1250 * 0.75)
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
