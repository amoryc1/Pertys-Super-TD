extends Area2D

var goldValue = 0
var canCollect = true
var autoCollect = false

func _ready():
	$CollisionShape2D.scale = $Sprite2D.scale
	if autoCollect:
		if canCollect:
			canCollect = false
			GLOBALVAR_PTD.money += goldValue
			$AnimationPlayer.play("collect")

func _process(delta):
	$Label.text = "+" + str(goldValue)
	$Sprite2D.modulate = Color.from_ok_hsl(1,1,1, $Timer.time_left/$Timer.wait_time*2)

func _mouse_enter():
	if canCollect:
		canCollect = false
		GLOBALVAR_PTD.money += goldValue
		$AnimationPlayer.play("collect")

func _on_timer_timeout():
	if canCollect:
		queue_free()


func _on_animation_player_animation_finished(anim_name):
	queue_free()
