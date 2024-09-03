extends Node2D


func _on_timer_timeout():
	$spawnTimer.wait_time = randf_range(0.4, 3.0)
	$spawnTimer.start()
	
	var chosen = load(GLOBALVAR_PTD.pertyStages[GLOBALVAR_PTD.pertyStages.keys().pick_random()])
	
	var clone = chosen.instantiate()
	clone.position = $start.position
	clone.scale = Vector2(1.5,1.5)
	$bin.add_child(clone)
