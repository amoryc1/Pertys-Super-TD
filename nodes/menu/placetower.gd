extends Button

@export var towerPath = "dart/darttower"
@export var posInList = 0

var realTowerPath
var canNotBePlaced = false

var noMouse = preload("res://mouse/noMouse.png")
var yesMouse = preload("res://mouse/placingMouse.png")
var normalMouse = preload("res://mouse/mouse.png")

func _ready():
	realTowerPath = "res://nodes/towers/" + towerPath + ".tscn"

# If a tower is selected, place it
func _input(_event): if visible:
	# Pressed shop button
	if !get_node("../../../upgrades").visible:
		
		if Input.is_action_just_pressed("MouseLeft") and !GLOBALVAR_PTD.placingTower and get_global_rect().has_point(get_global_mouse_position()):
			GLOBALVAR_PTD.placingTower = realTowerPath
			GLOBALVAR_PTD.mouseHoverStackCollision = 0
			
			var clone = load(realTowerPath).instantiate()
			
			get_node("../../../../towers").add_child(clone)
			
			if clone.cost <= GLOBALVAR_PTD.money:
				clone.active = false
				clone.find_child("ring").visible = true
				clone.name = "TEMP"
				clone.isMovingFromPurchase = true
			else: clone.queue_free() ; GLOBALVAR_PTD.placingTower = ""
		
		elif GLOBALVAR_PTD.placingTower != "":
			canNotBePlaced = false
			var target = get_node("../../../../towers/TEMP")
				# Let go of mouse
			if get_node("../..").get_global_rect().has_point(get_global_mouse_position()): canNotBePlaced = true
			elif GLOBALVAR_PTD.mouseHoverStackCollision != 0: canNotBePlaced = true
			# For traps
			elif GLOBALVAR_PTD.mouseHoverOverPath == false and target.isTrap == true: canNotBePlaced = true
			elif GLOBALVAR_PTD.mouseHoverOverPath == true and target.isTrap == false: canNotBePlaced = true
			# For water based towers
			elif GLOBALVAR_PTD.mouseHoverOverWater == false and target.isOnWater == true: canNotBePlaced = true
			elif GLOBALVAR_PTD.mouseHoverOverWater == true and target.isOnWater == false: canNotBePlaced = true
			
			# Change what the mouse looks like
			if canNotBePlaced: Input.set_custom_mouse_cursor(noMouse)
			else: Input.set_custom_mouse_cursor(yesMouse)
			
			if Input.is_action_just_released("MouseLeft"): # if a tower is purchased and is floating around, place it
				if !canNotBePlaced: # Place the tower
					target.find_child("ring").visible = false
					target.active = true
					target.isMovingFromPurchase = false
					target.name = "PLACED"
					target.modulate = Color8(255,255,255)
					
					# Change mouse back
					Input.set_custom_mouse_cursor(normalMouse)
					
					GLOBALVAR_PTD.mouseHoverStackCollision += 1 # when mouse leaves hitbox returns to 0
					GLOBALVAR_PTD.money -= target.cost
					GLOBALVAR_PTD.placedTowers[target.towerName] += 1
					GLOBALVAR_PTD.placingTower = ""
				else:
					target.queue_free()
					GLOBALVAR_PTD.placingTower = ""
			elif Input.is_action_pressed("MouseLeft"):
				if canNotBePlaced: target.modulate = Color8(255, 0, 0)
				else: target.modulate = Color8(255, 255, 255)
