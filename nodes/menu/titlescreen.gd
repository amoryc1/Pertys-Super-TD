extends Node2D

var acceptingInput = true

func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
	$version.text = GLOBALVAR_PTD.gameversion

func _input(event):
	if event is InputEventMouseButton and acceptingInput:
		acceptingInput = false
		GLOBALVAR_PTD.ticksAtLoadStart = Time.get_ticks_msec()
		
		var loadingScreenPath = get_node("LoadingScreen")
	
		loadingScreenPath.show()
		loadingScreenPath.find_child("nodepath").text = "Path: res://nodes/menu/menu.tscn"
		
		await get_tree().create_timer(0.02).timeout
		get_tree().change_scene_to_file("res://nodes/menu/menu.tscn")
