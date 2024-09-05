extends Area2D

var piercing = 1 # How many enemies can 1 particle hit
var damage = 0 # How much damage it deals
var speed = 20 # pixels/s
var vel = Vector2(0,0)
var glueLevelCount = 3
var isAnimated = false
var trueParent = ""

var targetlist = []

@export var gluelevel = 1

func _ready():
	if get_node_or_null(trueParent):
		glueLevelCount = get_node(trueParent).glueLevelCount

func _process(delta):
	position += (vel * speed * Engine.time_scale) * delta
	
	if len(targetlist) > 0:
		if piercing > 0:
			var enemy = get_node_or_null(targetlist[0])
			if enemy:
				if gluelevel == 1: enemy.status.append("glue")
				elif gluelevel == 2: enemy.status.append("glue2")
				elif gluelevel == 3: enemy.status.append("glue3")
				enemy.glueLevel = glueLevelCount
				
				targetlist.erase(targetlist[0])
				enemy.health -= damage
				piercing -= 1

	if piercing <= 0: queue_free()
	
	# Clear if particle gets off screen
	if (position.y > get_viewport_rect().size.y) or (position.y < 0): queue_free()
	if (position.x > get_viewport_rect().size.x) or (position.x < 0): queue_free()

func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		if not ((area.status.has("glue")) or (area.status.has("glue2")) or (area.status.has("glue3"))) and not (area.status.has("hot")):
			targetlist.append(area.get_path())
