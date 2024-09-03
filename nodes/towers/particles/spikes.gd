extends Area2D

@export var piercing = 3 # How many enemies can 1 particle hit
@export var damage = 1 # How much damage it deals

@export var cost = 30
@export var isTrap = false
@export var towerName = "Dart Tower"
@export var isOnWater = false
@export var canUpgrade = true

@export var canDetectCamo = false
@export var canHitLead = false

var targetlist = []
var active = false
var isMovingFromPurchase = false

func _process(_delta):
	if len(targetlist) > 0 and active:
		if piercing > 0:
			var enemy = get_node_or_null(targetlist[0])
			if enemy:
				enemy.health -= damage
				
				targetlist.erase(targetlist[0])
				piercing -= 1
				if piercing != 0: $Sprite2D.frame += 1

	if piercing <= 0: 
		if $StackCollision.mouseIn: GLOBALVAR_PTD.mouseHoverStackCollision -= 1
		queue_free()

	if isMovingFromPurchase: global_position = get_global_mouse_position()




func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		targetlist.append(area.get_path())
	
func _on_area_exited(area):
	if targetlist.has(area.get_path()):
		targetlist.erase(area.get_path())

