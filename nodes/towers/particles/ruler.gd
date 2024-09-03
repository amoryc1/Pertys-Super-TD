extends Area2D

var piercing = 1 # How many enemies can 1 particle hit
var damage = 1 # How much damage it deals
var speed = 20 # pixels/s
var vel = Vector2(0,0)
var isAnimated = false
var trueParent = ""
var returning = false

var canDetectParent = false # wait a bit to enable because the boomerang spawns in the true parent

var targetlist = []

func _ready():
	if isAnimated:
		$Sprite2D.play("default")
	$travel.wait_time = get_node(trueParent).travelTime
	$travel.start()
	var tween = create_tween()
	tween.tween_property($Sprite2D, "rotation", 1, $travel.wait_time * 2).set_trans(Tween.TRANS_SINE)
	tween.play()

func remove():
	get_node(trueParent).hasBoomerangOn += 1
	queue_free()

func _process(_delta):
	var travelAmt = vel * speed * Engine.time_scale
	
	if returning: position -= travelAmt
	else: position += travelAmt
	
	if len(targetlist) > 0:
		if piercing > 0:
			var enemy = get_node_or_null(targetlist[0])
			if enemy:
				enemy.health -= damage
				
				targetlist.erase(targetlist[0])
				piercing -= 1
	
	if piercing <= 0: 
		remove()
		

func _on_area_entered(area):
	if area.get_parent().is_class("PathFollow2D"):
		targetlist.append(area.get_path())
	
	if area.get_parent().get_path() == trueParent and canDetectParent:
		remove()


func _on_timer_timeout():
	canDetectParent = true


func _on_travel_timeout():
	returning = true
