extends PathFollow2D

func _process(_delta):
	progress += $Area2D.speed * GLOBALVAR_PTD.basePertySpeed * Engine.time_scale

	# Loop the path (optional)
	if progress > get_parent().curve.get_baked_length():
		progress = 0
