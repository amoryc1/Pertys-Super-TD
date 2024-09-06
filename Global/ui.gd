extends CanvasLayer

var load_time : int
var logical_core_count = 0
var processor_name = "Hi!"
var os_name = "TempleOS"

# Bless ChatGPT
func human_readable_size(size: int):
	var units = ["B", "KiB", "MiB", "GiB", "TiB"] # I dont think this game is using terabytes of ram... if it is im surprised you have terabytes of ram
	var index = 0

	while size >= 1024 and index < units.size() - 1:
		size /= 1024
		index += 1
	
	return str(size) + " " + units[index]

func _ready():
	load_time = Time.get_ticks_msec() - GLOBALVAR_PTD.ticks_at_load_start
	processor_name = OS.get_processor_name()
	logical_core_count = str(OS.get_processor_count())
	os_name = OS.get_name()

func _process(_delta):
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
