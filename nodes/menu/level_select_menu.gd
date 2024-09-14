extends Panel


func chosen_level(path):
	GLOBALVAR_PTD.won = false
	GLOBALVAR_PTD.in_game = true
	GLOBALVAR_PTD.health = 1 # prevent Game Over loop. Will go to proper hp when map fully loads
	GLOBALVAR_PTD.ticks_at_load_start = Time.get_ticks_msec()
	get_tree().change_scene_to_file(path)


func _on_levelselect_pressed(level_name: String) -> void:
	var difficultyNode = get_node("../difficultySelect")
	difficultyNode.find_child("mapName").text = level_name
	
	for x in GLOBALVAR_PTD.difficultys:
		if GLOBALVAR_PTD.level_win[level_name][1].has(x):
			var wave_num = GLOBALVAR_PTD.level_win[level_name][1][x][0][0]
			difficultyNode.find_child("continueText"+x).text = "Continue? (Wave " + str(wave_num) + ")"
		else:
			if x != "no":
				difficultyNode.find_child("continueText"+x).text = "Start new"
		
		if GLOBALVAR_PTD.level_win[level_name][0].has(x):
			var win_count = GLOBALVAR_PTD.level_win[level_name][0][x]
			if win_count >= 5: # Perty + Crown
				get_node("../difficultySelect/" + x.to_lower() + "Difficulty/won").frame = 2
			elif win_count > 0: # Perty
				get_node("../difficultySelect/" + x.to_lower() + "Difficulty/won").frame = 1
			else: # No Perty
				get_node("../difficultySelect/" + x.to_lower() + "Difficulty/won").frame = 0
			get_node("../difficultySelect/" + x.to_lower() + "Difficulty/won/Label").text = str(win_count) + " Wins"
	
	difficultyNode.visible = true


func _on_difficulty_pressed(difficulty_name: String) -> void:
	var level_name = get_node("../difficultySelect/mapName").text
	
	
	var loadingScreenPath = get_node("../LoadingScreen")
	var path = GLOBALVAR_PTD.map_nodes[level_name][difficulty_name]
	
	loadingScreenPath.show()
	loadingScreenPath.find_child("nodepath").text = "Path: " + path
	
	await get_tree().create_timer(0.02).timeout
	chosen_level(path)


func _on_close_pressed() -> void:
	get_node("../difficultySelect").visible = false


func _on_difficulty_mouse_entered(extra_arg_0: Color, extra_arg_1 = false) -> void:
	var stylebox = StyleBoxFlat.new()
	stylebox.border_color = extra_arg_0
	stylebox.border_blend = true
	if extra_arg_1: stylebox.border_width_bottom = 550 ; stylebox.border_width_top = 225
	else: stylebox.border_width_bottom = 300 ; stylebox.border_width_top = 150
	stylebox.bg_color = Color8(39,39,39)
	get_node("../difficultySelect").add_theme_stylebox_override("panel", stylebox)
