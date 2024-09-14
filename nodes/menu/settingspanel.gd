extends Panel

func chosen_level(path):
	GLOBALVAR_PTD.won = false
	GLOBALVAR_PTD.in_game = true
	GLOBALVAR_PTD.health = 1 # prevent Game Over loop. Will go to proper hp when map fully loads
	GLOBALVAR_PTD.ticks_at_load_start = Time.get_ticks_msec()
	get_tree().change_scene_to_file(path)

# Save the game
func _on_saveandexit_pressed() -> void:
	
	$saveandexit.text = "Saving..."
	var save_array = [[]]
	
	var level_name = get_node("../..").levelStats[0]["levelName"]
	var level_difficulty = get_node("../..").levelStats[0]["difficulty"]
	var tower_nodes = get_node("../../towers")
	
	save_array[0].append(get_node("../../enemyspawner").wave)
	save_array[0].append(GLOBALVAR_PTD.money)
	save_array[0].append(GLOBALVAR_PTD.health)
	save_array[0].append(level_difficulty)
	
	for x in tower_nodes.get_children():
		var array_for_save = [x.towerName, [x.global_position.x, x.global_position.y]]
		if x.canUpgrade:
			array_for_save.append([x.upgradeLevel1, x.upgradeLevel2, x.upgradeLevel3])
		else:
			array_for_save.append(false)
		array_for_save.append({})
		save_array.append(array_for_save)
	
	print("save_array for " + level_name + "/" + level_difficulty + ": "+ str(save_array))
	GLOBALVAR_PTD.level_win[level_name][1][level_difficulty] = save_array
	
	
	GLOBALVAR_PTD.save_data(GLOBALVAR_PTD.chosen_save_file)
	var path = "res://nodes/menu/menu.tscn"
	chosen_level(path)


func _on_deleteprogress_pressed() -> void:
	$confirm.visible = true

func _on_nah_pressed() -> void:
	$confirm.visible = false

func _on_yea_pressed() -> void:
	GLOBALVAR_PTD.end_game(get_node("../..").levelStats[0]["difficulty"], get_node("../..").levelStats[0]["levelName"], false)
