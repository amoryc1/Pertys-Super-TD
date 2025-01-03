extends Node2D

var bananaFileExists = false # _ready() checks if res://high quality banana.png exists.

func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, false)
	
	Engine.time_scale = 1
	# Load data and do stuff with it
	# only load once
	if GLOBALVAR_PTD.hasLoadedData == false:
		GLOBALVAR_PTD.hasLoadedData = true
		GLOBALVAR_PTD.load_data(GLOBALVAR_PTD.chosenSaveFile)
	
	Engine.max_fps = GLOBALVAR_PTD.fpsCap
	$SettingsMenu/advanced/maxFPS.text = str(GLOBALVAR_PTD.fpsCap)
	
	
	# achivements
	# Bronze -> Silver -> Gold -> Diamond
	if GLOBALVAR_PTD.levelWin["The Park"] == "Easy": $achievementRack/winTestMap.frame = 1
	if GLOBALVAR_PTD.levelWin["The Park"] == "Normal": $achievementRack/winTestMap.frame = 2
	if GLOBALVAR_PTD.levelWin["The Park"] == "Hard": $achievementRack/winTestMap.frame = 3
	if GLOBALVAR_PTD.levelWin["The Park"] == "Hardcore": $achievementRack/winTestMap.frame = 4
	
	
	
	$SettingsMenu/advanced/showDebug.button_pressed = GLOBALVAR_PTD.showDebug
	
	if GLOBALVAR_PTD.windowMode == "Fullscreen":
		$SettingsMenu/graphics/windowMode.text = "Window Mode: Fullscreen"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		$SettingsMenu/graphics/windowMode.text = "Window Mode: Windowed"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	
	
	if GLOBALVAR_PTD.vsyncMode == "Enabled":
		$SettingsMenu/advanced/maxFPS/vsync.text = "VSync: Enabled"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	elif GLOBALVAR_PTD.vsyncMode == "Disabled":
		$SettingsMenu/advanced/maxFPS/vsync.text = "VSync: Disabled"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	elif GLOBALVAR_PTD.vsyncMode == "Adaptive":
		$SettingsMenu/advanced/maxFPS/vsync.text = "VSync: Adaptive"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)
	elif GLOBALVAR_PTD.vsyncMode == "Mailbox":
		$SettingsMenu/advanced/maxFPS/vsync.text = "VSync: Mailbox"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_MAILBOX)
	
	$SettingsMenu/sounds/masterSlider.value = GLOBALVAR_PTD.masterVolume
	$SettingsMenu/sounds/masterSlider/amount.text = str(GLOBALVAR_PTD.masterVolume*100) + "%"
	
	$SettingsMenu/sounds/musicSlider.value = GLOBALVAR_PTD.musicVolume
	$SettingsMenu/sounds/musicSlider/amount.text = str(GLOBALVAR_PTD.musicVolume*100) + "%"
	
	$SettingsMenu/sounds/sfxSlider.value = GLOBALVAR_PTD.sfxVolume
	$SettingsMenu/sounds/sfxSlider/amount.text = str(GLOBALVAR_PTD.sfxVolume*100) + "%"
	
	$BGM.play()
	
	# No more load data
	
	if GLOBALVAR_PTD.won: $youwins.visible = true
	
	$eggBackground/spinningEgg.play("default")
	
	set_process_input(true)
	
	get_tree().root.title = "Tower Defense - Menus"
	
	if GLOBALVAR_PTD.health <= 0:
		$youdies.visible = true
	
	if load("res://high quality banana.png"):
		bananaFileExists = true
	else:
		$eggBackground/bananaBG.texture = load("res://no high quality banana very sad.png")
		$eggBackground/bananaBG.modulate.a = 1

var secretCode = ["ui_up","ui_up","ui_down","ui_down","ui_left","ui_right","ui_left","ui_right","konami_b","konami_a"]
var secretCodePos = 0
var canEnterCode = true
var eggFlownAway = false


func _input(event):
	if canEnterCode:
		if secretCodePos != len(secretCode):
			if Input.is_action_just_pressed(secretCode[secretCodePos]):
				
				$eggSFX.pitch_scale = 1 + (0.1 * secretCodePos)
				$eggSFX.play()
				
				print("Code Position: " + str(secretCodePos) + "   (" + str(secretCode[secretCodePos]) + ")")
				secretCodePos += 1
		else:
			on_code_entered()
	else:
		# control egg
		if $eggBackground/spinningEgg.speed_scale < 25:
			if Input.is_action_just_pressed("ui_up"):
				$eggBackground/spinningEgg.speed_scale += 1
				$eggBackground/showSpeedScale.text = str($eggBackground/spinningEgg.speed_scale)
			if Input.is_action_just_pressed("ui_down"):
				if 0 < $eggBackground/spinningEgg.speed_scale:
					$eggBackground/spinningEgg.speed_scale -= 1
					$eggBackground/showSpeedScale.text = str($eggBackground/spinningEgg.speed_scale)
			$eggBackground/fanSFX.pitch_scale = $eggBackground/spinningEgg.speed_scale/5
			$eggBackground/spinningEgg/CPUParticles2D.self_modulate.a=$eggBackground/spinningEgg.speed_scale/35
		else:
			if eggFlownAway == false:
				$AnimationPlayer.play("byebyeegg")
				eggFlownAway = true
			else:
				pass



func on_code_entered():
	$eggBackground.visible = true
	$eggBackground/fanSFX.play()
	print("Super Secret Code Entered!")
	$AnimationPlayer.play("egg")
	canEnterCode = false

func chosen_level(path):
	GLOBALVAR_PTD.won = false
	GLOBALVAR_PTD.inGame = true
	GLOBALVAR_PTD.health = 1 # prevent Game Over loop. Will go to proper hp when map fully loads
	GLOBALVAR_PTD.ticksAtLoadStart = Time.get_ticks_msec()
	get_tree().change_scene_to_file(path)
	
func _on_play_pressed():
	get_tree().root.title = "Choosing a map..."
	$AnimationPlayer.play("byebyebuttons")
	$tapSFX.play()

func _on_play_mouse_entered(): $Play.scale = Vector2(1.1, 1.1)
func _on_play_mouse_exited(): $Play.scale = Vector2(1, 1)


func _on_setting_pressed(): $SettingsMenu.visible = true ; $tapSFX.play()

func _on_setting_mouse_entered(): $Setting.scale = Vector2(1.1, 1.1)
func _on_setting_mouse_exited(): $Setting.scale = Vector2(1, 1)


func _on_achievements_pressed(): 
	$tapSFX.play()
	if $Achievements.text == ">": $AnimationPlayer.play("achievementslide")
	else: $AnimationPlayer.play_backwards("achievementslide")

func _on_achievements_mouse_entered(): $Achievements.scale = Vector2(1.1, 1.1)
func _on_achievements_mouse_exited(): $Achievements.scale = Vector2(1, 1)


func _on_testlevel_pressed():
	var loadingScreenPath = get_node("LoadingScreen")
	var path = "res://nodes/maps/testmap/main.tscn"
	
	loadingScreenPath.show()
	loadingScreenPath.find_child("nodepath").text = "Path: " + path
	
	await get_tree().create_timer(0.02).timeout
	chosen_level(path)


func _on_x_pressed():
	$tapSFX.play()
	$AnimationPlayer.play_backwards("byebyebuttons")


func _on_encyclopedia_pressed(): 
	$tapSFX.play()
	$EncyclopediaMenu.visible = true
	$EncyclopediaMenu.updateList("Tower")
