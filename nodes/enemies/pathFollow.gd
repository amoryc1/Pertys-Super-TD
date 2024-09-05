extends PathFollow2D

func _process(delta):
	progress += ($Area2D.speed * GLOBALVAR_PTD.base_perty_speed * Engine.time_scale) * delta

	# Loop the path (optional)
	if progress > get_parent().curve.get_baked_length():
		progress = 0
