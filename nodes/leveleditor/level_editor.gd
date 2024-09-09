extends Node2D

# TODO
# A crap ton of stuff

var spawnpartID = 0
var startingHealth = 100
var startingMoney = 200
var waveCount = 1
var currentWave = 1
var difficultyName = "Normal"
var currentStatus = []
var cashMultiplier = 1

var pertyType = "Normal"
var pertyTypeImageFrame = 0

# First part is a dict for some the level variables everything else is the wave
var currentWaveArray = [
	{
		"levelName": "New Level",
		"difficulty": "Normal",
		"startingHealth": 100,
		"startingMoney": 200,
		"cashMultiplier": 1,
		"events": {
			1: {}
		}
	},
	[]
]

func update_event_list():
	# Sort out events
	
	if $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/enable/yeaCheckbox.button_pressed:
		# Earn money
		if $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/activeCheckbox.button_pressed:
			var earn_amt = int($bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/amountLineedit.text)
			var on_start_val = $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/onstartCheckbox.button_pressed
			var overwrite_val = $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/overwriteCheckbox.button_pressed
			var multiplier_effect = $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/multieffectCheckbox.button_pressed
			currentWaveArray[0]["events"][currentWave]["earn_money"] = {}
			currentWaveArray[0]["events"][currentWave]["earn_money"]["active"] = true
			currentWaveArray[0]["events"][currentWave]["earn_money"]["amount"] = earn_amt
			currentWaveArray[0]["events"][currentWave]["earn_money"]["on_start"] = on_start_val
			currentWaveArray[0]["events"][currentWave]["earn_money"]["overwrite"] = overwrite_val
			currentWaveArray[0]["events"][currentWave]["earn_money"]["multipler_effect"] = multiplier_effect
		else:
			currentWaveArray[0]["events"][currentWave]["earn_money"] = {"active":false}
	
		# Show Message
		if $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/activeCheckbox.button_pressed:
			var on_start_val = $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/onstartCheckbox.button_pressed
			var message_val = $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/messageTextedit.text
			currentWaveArray[0]["events"][currentWave]["show_message"] = {}
			currentWaveArray[0]["events"][currentWave]["show_message"]["active"] = true
			currentWaveArray[0]["events"][currentWave]["show_message"]["on_start"] = on_start_val
			currentWaveArray[0]["events"][currentWave]["show_message"]["message"] = message_val
		else:
			currentWaveArray[0]["events"][currentWave]["show_message"] = {"active":false}
	else:
		currentWaveArray[0]["events"][currentWave] = {}

func _on_set_pressed():
	# turn to ints
	$bottombar/spawnamount.text         = str(int($bottombar/spawnamount.text))
	$bottombar/startingcash.text        = str(int($bottombar/startingcash.text))
	$bottombar/cashmultiplier.text      = str(int($bottombar/cashmultiplier.text))
	$bottombar/startinglife.text        = str(int($bottombar/startinglife.text))
	# turn to floats
	$bottombar/spawntime.text = str(float($bottombar/spawntime.text))
	
	startingHealth      = int($bottombar/startinglife.text)
	startingMoney       = int($bottombar/startingcash.text)
	cashMultiplier      = int($bottombar/cashmultiplier.text)
	difficultyName      = $bottombar/difficultyname.text
	currentStatus       = []
	
	if $bottombar/statusMenu/hot.button_pressed:     currentStatus.append("hot")
	if $bottombar/statusMenu/camo.button_pressed:    currentStatus.append("camo")
	if $bottombar/statusMenu/metal.button_pressed:   currentStatus.append("metal")
	if $bottombar/statusMenu/fast.button_pressed:    currentStatus.append("fast")
	if $bottombar/statusMenu/shield.button_pressed:    currentStatus.append("shield")
	
	# Show menu in list
	
	var menuClone = $bottombar/waves/list/ScrollContainer/VBoxContainer/example
	
	# If spawntime or spawnamount = 0 then change it to a low value to not break anything.
	# (a value of 0 shouldnt but i want to be safe)
	
	if $bottombar/spawntime.text == "0": $bottombar/spawntime.text = "0.1"
	if $bottombar/spawnamount.text == "0": $bottombar/spawnamount.text = "1"
	
	# Forces starting life to be atleast 1 otherwise the player instantly dies
	if $bottombar/startinglife.text == "0": $bottombar/startinglife.text = "1"
	
	menuClone.find_child("title").text           = pertyType + " Perty"
	menuClone.find_child("pertyIcon").frame      = pertyTypeImageFrame
	menuClone.find_child("status").text          = str(currentStatus)
	menuClone.find_child("time").text            = $bottombar/spawntime.text
	menuClone.find_child("amount").text          = $bottombar/spawnamount.text
	menuClone.find_child("wavenumber").text      = str(currentWave)
	menuClone.find_child("id").text              = str(len(currentWaveArray[currentWave]))
	
	var menuClone2 = menuClone.duplicate()
	menuClone2.name = str(spawnpartID)
	$bottombar/waves/list/ScrollContainer/VBoxContainer.add_child(menuClone2)
	
	menuClone2.visible = true
	
	update_event_list()
	# Add to the array
	
	currentWaveArray[0]["difficulty"] = difficultyName
	currentWaveArray[0]["startingHealth"] = startingHealth
	currentWaveArray[0]["startingMoney"] = startingMoney
	currentWaveArray[0]["cashMultiplier"] = cashMultiplier
	currentWaveArray[0]["levelName"] = $bottombar/levelname.text
	# currentWaveArray[0]["events"] sorted up there ^
	

	
	currentWaveArray[currentWave].append([
			pertyType, int($bottombar/spawnamount.text), float($bottombar/spawntime.text), currentStatus
		]
	)
	
	
	
	spawnpartID += 1

func _on_status_pressed():
	var x = !$bottombar/statusMenu.visible
	$bottombar/statusMenu.visible = x
	if x: $bottombar/status.text = "Hide status menu"
	else: $bottombar/status.text = "Show status menu"


func _on_pertytype_pressed():
	var x = !$bottombar/pertytypeMenu.visible
	$bottombar/pertytypeMenu.visible = x
	if x: $bottombar/pertytype.text = "Hide Perty type"
	else: $bottombar/pertytype.text = "Show Perty type"

# Shows the save array text
func _on_showsave_pressed():
	$bottombar/saveArrayMenu/copyToClipboard.text = "Copy to clipboard"
	var x = !$bottombar/saveArrayMenu.visible
	$bottombar/saveArrayMenu.visible = x
	if x: $bottombar/showsave.text = "Hide save"
	else: $bottombar/showsave.text = "Show save"
	
	$bottombar/saveArrayMenu/TextEdit.text = str(currentWaveArray)

func _on_howtouse_pressed():
	var x = !$bottombar/howToUseMenu.visible
	$bottombar/howToUseMenu.visible = x
	if x: $bottombar/howtouse.text = "Hide How to use"
	else: $bottombar/howtouse.text = "Show How to use"


# Change wave view
func updatePertyList():
	$sfx/clickSFX.play()
	var i = currentWave
	$bottombar/waves/wavenumber.text = "Wave " + str(i)
	for x in $bottombar/waves/list/ScrollContainer/VBoxContainer.get_children():
		if x.name != "example":
			var y = int(x.get_child(0).text) # 0 = wave number
			if y == i: x.visible = true
			else: x.visible = false
	
	# extend array if the new wave is a bigger value then the max wave
	if waveCount < currentWave:
		currentWaveArray.append([])
		currentWaveArray[0]["events"][currentWave] = {}
		waveCount += 1
	
	# eventpanel
			
	if len(currentWaveArray[0]["events"][currentWave]) > 0:
		$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/enable/yeaCheckbox.button_pressed = true
		$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney.visible = true
		$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage.visible = true
		
		if currentWaveArray[0]["events"][currentWave].has("earn_money"):
			if currentWaveArray[0]["events"][currentWave]["earn_money"]["active"]:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/activeCheckbox.button_pressed = true
			else:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/activeCheckbox.button_pressed = false
			
			if currentWaveArray[0]["events"][currentWave]["earn_money"].has("amount"):
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/amountLineedit.text = str(currentWaveArray[0]["events"][currentWave]["earn_money"]["amount"])
			else:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/amountLineedit.text = ""
			if currentWaveArray[0]["events"][currentWave]["earn_money"].has("on_start"):
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/onstartCheckbox.button_pressed = true
			else:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/onstartCheckbox.button_pressed = false
			if currentWaveArray[0]["events"][currentWave]["earn_money"].has("overwrite"):
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/overwriteCheckbox.button_pressed = true
			else:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/overwriteCheckbox.button_pressed = false
			if currentWaveArray[0]["events"][currentWave]["earn_money"].has("multipler_effect"):
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/multieffectCheckbox.button_pressed = true
			else:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney/multieffectCheckbox.button_pressed = false

		if currentWaveArray[0]["events"][currentWave].has("show_message"):
			if currentWaveArray[0]["events"][currentWave]["show_message"]["active"]:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/activeCheckbox.button_pressed = true
			else:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/activeCheckbox.button_pressed = false
			
			if currentWaveArray[0]["events"][currentWave]["show_message"].has("message"):
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/messageTextedit.text = currentWaveArray[0]["events"][currentWave]["show_message"]["message"]
			else:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/messageTextedit.text = ""
			if currentWaveArray[0]["events"][currentWave]["show_message"].has("on_start"):
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/onstartCheckbox.button_pressed = true
			else:
				$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage/onstartCheckbox.button_pressed = false

	else:
		$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/enable/yeaCheckbox.button_pressed = false
		$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney.visible = false
		$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage.visible = false

		

# Update perty list when something is deleted.
# FUCK THIS
# HELP ME THIS WONT WORK
# IF YOU ARE SEEING THIS IN GODOT ENGINE JUST MAKE THE 'bottombar/waves/list/example/trash' NODE VISIBLE TO SEE HOW BROKEN THIS SHIT IS
func updatePertyListOnDelete(deletedID):

	for x in $bottombar/waves/list.get_children():
		var y = int(x.get_child(0).text) # 0 = wave number
		if x.name != "example" and y == currentWave and x.name != "_Hey_ Good job looking at my code! Have you gouged your eyes out yet?_": 
			var intName = int(x.get_child(1).text)
			if intName > deletedID:
				x.get_child(0).text = str(intName - 1)
				x.position.y = 8 + ((intName - 2) * 64)
			elif intName == deletedID:
				print("How the hell is this here? I've gone insane trying to fix a bug but its still here??? HELP ME")
	
	#updatePertyList()

func _on_right_pressed():
	currentWave += 1
	updatePertyList()

func _on_left_pressed():
	if currentWave > 1: currentWave -= 1 ; updatePertyList()
	else: $sfx/errorSFX.play()



func _on_goback_pressed():
	var loadingScreenPath = get_node("LoadingScreen")
	var path = "res://nodes/menu/menu.tscn"
	
	loadingScreenPath.show()
	loadingScreenPath.find_child("nodepath").text = "Path: " + path
	
	GLOBALVAR_PTD.ticks_at_load_start = Time.get_ticks_msec()
	
	await get_tree().create_timer(0.02).timeout
	get_tree().change_scene_to_file(path)


func _on_copy_to_clipboard_pressed() -> void:
	DisplayServer.clipboard_set($bottombar/saveArrayMenu/TextEdit.text)
	$bottombar/saveArrayMenu/copyToClipboard.text = "Copied!"


func _on_pertychosen_pressed(extra_arg_0: String) -> void:
	pertyType = extra_arg_0.capitalize()
	
	pertyTypeImageFrame = GLOBALVAR_PTD.perty_stages[extra_arg_0][1]
	
	for x in $bottombar/pertytypeMenu.get_children():
		x.button_pressed = false

	get_node("bottombar/pertytypeMenu/" + extra_arg_0).button_pressed = true


func _on_events_pressed() -> void:
	$bottombar/waves/eventpanel.visible = !$bottombar/waves/eventpanel.visible


func _on_yea_checkbox_pressed() -> void:
	var x = $bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/enable/yeaCheckbox.button_pressed
	$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/earnmoney.visible = x
	$bottombar/waves/eventpanel/ScrollContainer/VBoxContainer/showmessage.visible = x
