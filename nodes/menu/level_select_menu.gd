extends Panel


func chosen_level(path):
	GLOBALVAR_PTD.won = false
	GLOBALVAR_PTD.in_game = true
	GLOBALVAR_PTD.health = 1 # prevent Game Over loop. Will go to proper hp when map fully loads
	GLOBALVAR_PTD.ticks_at_load_start = Time.get_ticks_msec()
	get_tree().change_scene_to_file(path)


func _on_theparkeasy_pressed() -> void:
	var loadingScreenPath = get_node("../LoadingScreen")
	var path = "res://nodes/maps/testmap/main.tscn"
	
	loadingScreenPath.show()
	loadingScreenPath.find_child("nodepath").text = "Path: " + path
	
	await get_tree().create_timer(0.02).timeout
	chosen_level(path)
