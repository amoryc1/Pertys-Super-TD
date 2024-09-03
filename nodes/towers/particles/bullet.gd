extends Area2D

var piercing = 1 # How many enemies can 1 particle hit
var damage = 1 # How much damage it deals
var speed = 20 # pixels/s
var vel = Vector2(0,0)
var isAnimated = false
var trueParent = ""

var targetlist = []

func _ready():
	if isAnimated:
		$Sprite2D.play("default")

func _process(_delta):
	position += vel * speed * Engine.time_scale
	
	if len(targetlist) > 0:
		if piercing > 0:
			var enemy = get_node_or_null(targetlist[0])
			if enemy:
				enemy.health -= damage
				
				targetlist.erase(targetlist[0])
				piercing -= 1

	if piercing <= 0: queue_free()
	
	# Clear if particle gets off screen
	if (position.y > get_viewport_rect().size.y) or (position.y < 0): queue_free()
	if (position.x > get_viewport_rect().size.x) or (position.x < 0): queue_free()

func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		targetlist.append(area.get_path())
