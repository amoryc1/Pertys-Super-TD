extends Node2D

var acceptingInput = true

func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
	$version.text = GLOBALVAR_PTD.game_version

func _input(event):
	if event is InputEventMouseButton and acceptingInput:
		acceptingInput = false
		GLOBALVAR_PTD.ticks_at_load_start = Time.get_ticks_msec()
		
		var loading_screen_path = get_node("LoadingScreen")
	
		loading_screen_path.show()
		loading_screen_path.find_child("nodepath").text = "Path: res://nodes/menu/menu.tscn"
		
		await get_tree().create_timer(0.02).timeout
		get_tree().change_scene_to_file("res://nodes/menu/menu.tscn")
