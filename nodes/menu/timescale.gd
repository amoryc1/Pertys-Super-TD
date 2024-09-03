extends Panel

func _on_change_speed_pressed():
	if Engine.time_scale == 1:
		Engine.time_scale = 2.5
		$changeSpeed.texture_normal.region = Rect2(32, 0, 32, 32)
	else:
		Engine.time_scale = 1
		$changeSpeed.texture_normal.region = Rect2(0, 0, 32, 32)
