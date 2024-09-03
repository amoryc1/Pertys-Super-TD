extends AudioStreamPlayer

func _ready():
	if get_parent().name == "enemyspawner":
		await get_tree().create_timer(0.5).timeout
		queue_free()
