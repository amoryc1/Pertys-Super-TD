extends CanvasLayer

# Bless ChatGPT
func human_readable_size(size: int):
	var units = ["B", "KiB", "MiB", "GiB", "TiB"] # I dont think this game is using terabytes of ram... if it is im surprised you have terabytes of ram
	var index = 0

	while size >= 1024 and index < units.size() - 1:
		size /= 1024
		index += 1
	
	return str(size) + " " + units[index]

func _ready():
	$debug/lastLoadTime.text = "Last load time: " + str(Time.get_ticks_msec() - GLOBALVAR_PTD.ticksAtLoadStart) + "ms"


func _process(_delta):
	if GLOBALVAR_PTD.showDebug:
		$debug/counter.text = "FPS: " + str(Engine.get_frames_per_second())
		var currentMemory = OS.get_static_memory_usage()
		var peakMemory = OS.get_static_memory_peak_usage()
		$debug/ram.text = "Memory: " + str(human_readable_size(currentMemory)) + " / " + str(human_readable_size(peakMemory)) 
	
	$debug.visible = GLOBALVAR_PTD.showDebug

func _input(event):
	if Input.is_action_just_pressed("f11"):
		if GLOBALVAR_PTD.windowMode == "Windowed":
			GLOBALVAR_PTD.windowMode = "Fullscreen"
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			GLOBALVAR_PTD.windowMode = "Windowed"
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	if Input.is_action_just_pressed("debugvis"):
		GLOBALVAR_PTD.showDebug = !GLOBALVAR_PTD.showDebug
