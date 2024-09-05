extends Panel
# Settings Menu =]

func makeNotification(text):
	var clone = get_node("../notificationTemplate").duplicate()
	clone.name = "temp"
	clone.text = text
	clone.visible = true
	get_node("../bin").add_child(clone)
	clone.get_child(0).play("new_animation")

func _on_close_pressed(): visible = false ;get_node("../tapSFX").play()

# Level Editor

func _on_level_editor_pressed(): 
	get_node("../tapSFX").play()
	var loadingScreenPath = get_node("../LoadingScreen")
	var path = "res://nodes/leveleditor/level_editor.tscn"
	
	loadingScreenPath.show()
	loadingScreenPath.find_child("nodepath").text = "Path: " + path
	
	await get_tree().create_timer(0.02).timeout
	GLOBALVAR_PTD.ticks_at_load_start = Time.get_ticks_msec()
	get_tree().change_scene_to_file(path)

# Sounds Tab
func change_volume(value, busName): # credit : https://www.gdquest.com/tutorial/godot/audio/volume-slider/
	var _bus := AudioServer.get_bus_index(busName)
	AudioServer.set_bus_volume_db(_bus, linear_to_db(value))

func _on_master_slider_value_changed(value):
	$sounds/masterSlider/amount.text = str(value*100) + "%"
	GLOBALVAR_PTD.master_volume = value
	change_volume(value, "Master")

func _on_music_slider_value_changed(value):
	$sounds/musicSlider/amount.text = str(value*100) + "%"
	GLOBALVAR_PTD.music_volume = value
	change_volume(value, "Music")

func _on_sfx_slider_value_changed(value):
	$sounds/sfxSlider/amount.text = str(value*100) + "%"
	GLOBALVAR_PTD.sfx_volume = value
	change_volume(value, "SFX")


func _on_maxFPS_pressed():
	get_node("../tapSFX").play()
	var newVal = int($advanced/maxFPS.text)
	if newVal < 5: newVal = 5 # min 5 fps
	$advanced/maxFPS.text = str(newVal)
	
	Engine.max_fps = newVal
	GLOBALVAR_PTD.fps_cap = newVal

func _on_vsync_pressed():
	get_node("../tapSFX").play()
	if $advanced/maxFPS/vsync.text == "VSync: Enabled":
		$advanced/maxFPS/vsync.text = "VSync: Disabled"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		GLOBALVAR_PTD.vsync_mode = "Disabled"
	elif $advanced/maxFPS/vsync.text == "VSync: Disabled":
		$advanced/maxFPS/vsync.text = "VSync: Adaptive"
		GLOBALVAR_PTD.vsync_mode = "Adaptive"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	elif $advanced/maxFPS/vsync.text == "VSync: Adaptive":
		$advanced/maxFPS/vsync.text = "VSync: Mailbox"
		GLOBALVAR_PTD.vsync_mode = "Mailbox"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	elif $advanced/maxFPS/vsync.text == "VSync: Mailbox":
		$advanced/maxFPS/vsync.text = "VSync: Enabled"
		GLOBALVAR_PTD.vsync_mode = "Enabled"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		$advanced/maxFPS/vsync.text = "VSync: Enabled"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		GLOBALVAR_PTD.vsync_mode = "Enabled"
	
	print($advanced/maxFPS/vsync.text)

# Menus
func openMenu(mName, bName):
	get_node("../tapSFX").play()
	$sounds.hide()
	$soundMenu.set_text_alignment(HORIZONTAL_ALIGNMENT_LEFT)
	$advanced.hide()
	$advancedMenu.set_text_alignment(HORIZONTAL_ALIGNMENT_LEFT)
	$graphics.hide()
	$graphicsMenu.set_text_alignment(HORIZONTAL_ALIGNMENT_LEFT)
	
	get_node(mName).show()
	get_node(bName).set_text_alignment(HORIZONTAL_ALIGNMENT_RIGHT)

func _on_sound_menu_pressed(): openMenu("sounds", "soundMenu")
func _on_advanced_menu_pressed(): openMenu("advanced", "advancedMenu")
func _on_graphics_menu_pressed(): openMenu("graphics", "graphicsMenu")


func _on_save_pressed():
	get_node("../tapSFX").play()
	var x = GLOBALVAR_PTD.save_data(GLOBALVAR_PTD.chosen_save_file)
	if x[0]: 
		makeNotification("Saved at " + str(x[1]))
	else: 
		makeNotification("Saving Failed")


func _on_window_mode_pressed():
	get_node("../tapSFX").play()
	if $graphics/windowMode.text == "Window Mode: Fullscreen":
		$graphics/windowMode.text = "Window Mode: Windowed"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		GLOBALVAR_PTD.window_mode = "Windowed"
	else:
		$graphics/windowMode.text = "Window Mode: Fullscreen"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		GLOBALVAR_PTD.window_mode = "Fullscreen"


func _on_show_debug_pressed():
	get_node("../tapSFX").play()
	GLOBALVAR_PTD.show_debug = $advanced/showDebug.button_pressed
