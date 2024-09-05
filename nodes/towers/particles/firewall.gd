extends Area2D

var piercing = 1 # How many enemies can 1 particle hit
var damage = 1 # How much damage it deals
var speed = 20 # pixels/s
var vel = Vector2(0,0)
@export var sizeMult = 1.00
@export var animationSpeed = 1.00
var isAnimated = false
var trueParent = ""
var applyFire = false

var ripStatus = []

var targetlist = []

func _ready():
	if get_node(trueParent).upgradeLevel1 == 1:
		sizeMult = 1.4
		animationSpeed = 0.8
	elif get_node(trueParent).upgradeLevel1 == 2:
		sizeMult = 1.7
		animationSpeed = 0.6
	
	if isAnimated:
		$Sprite2D.play("default")

func _process(delta):
	position += (vel * speed) * delta
	
	if len(targetlist) > 0:
		
		var enemy = get_node_or_null(targetlist[0])
		if enemy:
			enemy.health -= damage
			
			for x in ripStatus:
				if enemy.status.has(x):
					enemy.status.erase(x)
			
			if applyFire: enemy.status.append("fire")
			
			targetlist.erase(targetlist[0])
			piercing -= 1

	if piercing <= 0:
		$Sprite2D.speed_scale = animationSpeed
		$Sprite2D.play("default")
		$Sprite2D.scale = Vector2(2*sizeMult,2*sizeMult)
		$Sprite2D.z_index = 101
		$CollisionShape2D.shape.radius = 30*sizeMult
		speed = 0
	
	# Clear if particle gets off screen
	if (position.y > get_viewport_rect().size.y) or (position.y < 0): queue_free()
	if (position.x > get_viewport_rect().size.x) or (position.x < 0): queue_free()

func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		targetlist.append(area.get_path())


func _on_sprite_2d_animation_finished():
	queue_free()
