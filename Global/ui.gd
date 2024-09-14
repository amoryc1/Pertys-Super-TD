extends CanvasLayer

var load_time : int
var logical_core_count = 0
var processor_name = "Hi!"
var os_name = "TempleOS"

var old_exp = 0

# Bless ChatGPT
func human_readable_size(size: int):
	var units = ["B", "KiB", "MiB", "GiB", "TiB"] # I dont think this game is using terabytes of ram... if it is im surprised you have terabytes of ram
	var index = 0

	while size >= 1024 and index < units.size() - 1:
		size /= 1024
		index += 1
	
	return str(size) + " " + units[index]

func capture_screenshot():
	# Get the viewport's texture
	var image_texture = get_viewport().get_texture()

	# Extract the image from the texture
	var image = image_texture.get_image()
	
	$screenshotPreview.visible = true
	$screenshotPreview.texture = ImageTexture.create_from_image(image)
	
	$AnimationPlayer.play("screenshot")
	$screenshotPreview.self_modulate.a = 1
	$screenshotPreview.visible = true
	$screenshotPreview/screenshotPreviewTimer.start()
	
	var dir = DirAccess.open("user://" + GLOBALVAR_PTD.screenshot_folder)
	if dir == null:
		DirAccess.make_dir_absolute("user://" + GLOBALVAR_PTD.screenshot_folder)
	
	# Save the image as a PNG in the user:// folder
	
	await RenderingServer.frame_post_draw
	
	var file_name = GLOBALVAR_PTD.screenshot_folder + "/" + "screenshot_" + str(int(Time.get_unix_time_from_system())) + ".png"
	image.save_png(OS.get_user_data_dir() + "/" + file_name)
	
	if FileAccess.file_exists(OS.get_user_data_dir() + "/" + file_name):
		if GLOBALVAR_PTD.hide_user:
			$screenshotPreview/filepath.text = "user://" + file_name
		else:
			$screenshotPreview/filepath.text = OS.get_user_data_dir() + "/" + file_name
		
	else: $screenshotPreview/filepath.text = "Did not save."
	
	if GLOBALVAR_PTD.hide_user:
		print("Screenshot saved as: user://" + file_name)
	else:
		print("Screenshot saved as: " + OS.get_user_data_dir() + "/" + file_name)

func update_expbar(vis):
	var requirement = GLOBALVAR_PTD.calculate_xp_for_levelup()
	$expbar.visible = vis
	
	if GLOBALVAR_PTD.exp >= requirement:
		GLOBALVAR_PTD.exp -= requirement
		GLOBALVAR_PTD.level += 1
	
	if vis:
		if GLOBALVAR_PTD.exp > old_exp:
			$expbar/AnimationPlayer.stop()
			$expbar/AnimationPlayer.play("exp_gain")
			$expbar/plus.text = "+" + str(GLOBALVAR_PTD.exp - old_exp)
		$expbar.max_value = requirement
		$expbar.value = GLOBALVAR_PTD.exp
		$expbar/level.text = "Level " + str(GLOBALVAR_PTD.level) + " (" + str(GLOBALVAR_PTD.exp) + "/" + str(requirement) + ")"
	
	old_exp = GLOBALVAR_PTD.exp

func _ready():
	old_exp = GLOBALVAR_PTD.exp
	$expbar/plus.self_modulate.a = 0
	update_expbar(GLOBALVAR_PTD.show_exp_bar)
	
	if GLOBALVAR_PTD.in_game: # Move out of the way of the tower list
		$expbar.position.x = 855
	
	load_time = Time.get_ticks_msec() - GLOBALVAR_PTD.ticks_at_load_start
	processor_name = OS.get_processor_name()
	logical_core_count = str(OS.get_processor_count())
	os_name = OS.get_name()

func _process(_delta):
	update_expbar(GLOBALVAR_PTD.show_exp_bar)
	$expbar.visible = GLOBALVAR_PTD.show_exp_bar
	
	if GLOBALVAR_PTD.show_debug:
		var current_memory = OS.get_static_memory_usage()
		var peak_memory = OS.get_static_memory_peak_usage()
		
		$debug/text.text = str(Engine.get_frames_per_second()) + "/" + str(GLOBALVAR_PTD.fps_cap) + " FPS"
		$debug/text.text += "\nVSync mode: " + GLOBALVAR_PTD.vsync_mode
		
		$debug/text.text += "\nOS: " + str(os_name)
		$debug/text.text += "\n" + processor_name + " (" + str(logical_core_count) + " L. Cores)"
		
		$debug/text.text += "\nMemory Used: " + str(human_readable_size(current_memory)) + " / " + str(human_readable_size(peak_memory)) 
		
		$debug/text.text += "\nLast load time: " + str(load_time) + "ms"
		
		$debug/text.text += "\n" + str(Performance.get_monitor(Performance.OBJECT_COUNT)) + " objects loaded (" + str(get_tree().get_node_count()) + " nodes)"
		

	
	$debug.visible = GLOBALVAR_PTD.show_debug

func _input(event):
	if Input.is_action_just_pressed("f11"):
		if GLOBALVAR_PTD.window_mode == "Windowed":
			GLOBALVAR_PTD.window_mode = "Fullscreen"
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			GLOBALVAR_PTD.window_mode = "Windowed"
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if Input.is_action_just_pressed("debugvis"):
		GLOBALVAR_PTD.show_debug = !GLOBALVAR_PTD.show_debug
	
	if Input.is_action_just_pressed("f12"):
		capture_screenshot()


func _on_screenshot_preview_timer_timeout() -> void:
	$screenshotPreview.visible = false
