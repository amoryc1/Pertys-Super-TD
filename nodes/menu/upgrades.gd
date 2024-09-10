extends Panel

var towerPath = ""
var lockedPath = -1

# Checks upgrade values to determine if a path should be locked
func check_values_for_lock(v1, v2, v3) -> Array:
	# Check if v1 v2 or v3 are bigger then 0 and apply that to the array
	var value_array = [v1, v2, v3]
	var count = 0
	var count3 = 0 # number of 3 upgrades
	var count2 = 0 # number of 2 upgrades
	var false_index = -1
	
	var x = -1
	var y = -1
	
	var iteration = 0
	for i in value_array:
		iteration += 1
		if i > 0: 
			count += 1
		else: 
			false_index = iteration
		
		if i == 2: count2 = iteration
		if i == 3: count3 = iteration
	
	
	if count >= 2: # If 2 upgrades are unlocked lock one path
		x = false_index
	if count3 > 0 and count2 > 0: # if one path is lvl 2 and the other is lvl 3 lock the level 2
		y = count2
	
	return [x, y]


func update_text(child, upg, tower, tier):
	var updgLevel = get_node(towerPath).upgradeLevel1
	if child == "upgrade2": updgLevel = get_node(towerPath).upgradeLevel2
	if child == "upgrade3": updgLevel = get_node(towerPath).upgradeLevel3
	
	get_node(child + "/lock").visible = false
	get_node(child + "/Button").disabled = false
	
		
	# Lock path
	for x in check_values_for_lock(get_node(towerPath).upgradeLevel1,get_node(towerPath).upgradeLevel2,get_node(towerPath).upgradeLevel3):
		if child == "upgrade" + str(x):
			get_node(child + "/lock").visible = true
			get_node(child + "/Button").disabled = true
	
	
	if updgLevel >= 3:
		get_node(child + "/title").text = "Max Level"
		get_node(child + "/cost").text  = "Max Level"
		get_node(child + "/desc").text = str(GLOBALVAR_PTD.tower_upgrades[tower.towerName][tier][3]["desc"])
		get_node(child + "/Sprite2D").texture = load("res://assets/towers/"+str(GLOBALVAR_PTD.tower_upgrades[tower.towerName][tier][3]["sprite"]))
	else:
		get_node(child + "/title").text = str(GLOBALVAR_PTD.tower_upgrades[tower.towerName][tier][upg+1]["name"])
		get_node(child + "/desc").text = str(GLOBALVAR_PTD.tower_upgrades[tower.towerName][tier][upg+1]["desc"])
		get_node(child + "/cost").text  = str(GLOBALVAR_PTD.tower_upgrades[tower.towerName][tier][upg+1]["cost"])
		get_node(child + "/Sprite2D").texture = load("res://assets/towers/"+str(GLOBALVAR_PTD.tower_upgrades[tower.towerName][tier][upg+1]["sprite"]))
		get_node(child + "/Sprite2D").frame = GLOBALVAR_PTD.tower_upgrades[tower.towerName][tier][upg+1]["spriteFrame"]
	# Change blocks in the upgrade menu

	
	if updgLevel >= 1: get_node(child + "/amount/1").visible = true
	else: get_node(child + "/amount/1").visible = false
	if updgLevel >= 2: get_node(child + "/amount/2").visible = true
	else: get_node(child + "/amount/2").visible = false
	if updgLevel >= 3: get_node(child + "/amount/3").visible = true
	else: get_node(child + "/amount/3").visible = false
	
	
	$sell.text = "Sell (" + str(get_node(towerPath).sellValue) + ")"
		


func open():
	update_text("upgrade1", get_node(towerPath).upgradeLevel1, get_node(towerPath), 1)
	update_text("upgrade2", get_node(towerPath).upgradeLevel2, get_node(towerPath), 2)
	update_text("upgrade3", get_node(towerPath).upgradeLevel3, get_node(towerPath), 3)

func _on_close_pressed():
	visible = false
	get_node("upgrade1/amount/1").visible = false
	get_node("upgrade1/amount/2").visible = false
	get_node("upgrade1/amount/3").visible = false

	get_node("upgrade2/amount/1").visible = false
	get_node("upgrade2/amount/2").visible = false
	get_node("upgrade2/amount/3").visible = false


	get_node("upgrade3/amount/1").visible = false
	get_node("upgrade3/amount/2").visible = false
	get_node("upgrade3/amount/3").visible = false

func _on_texture_button1_pressed(): if get_node(towerPath).upgradeLevel1 < 3:
	var cost = GLOBALVAR_PTD.tower_upgrades[get_node(towerPath).towerName][1][get_node(towerPath).upgradeLevel1+1]["cost"]
	print(str(cost) + " : " + str(GLOBALVAR_PTD.money))
	if GLOBALVAR_PTD.money >= cost:
		get_node(towerPath).upgradeLevel1 += 1
		GLOBALVAR_PTD.money -= cost
		open()

func _on_texture_button2_pressed(): if get_node(towerPath).upgradeLevel2 < 3:
	var cost = GLOBALVAR_PTD.tower_upgrades[get_node(towerPath).towerName][2][get_node(towerPath).upgradeLevel2+1]["cost"]
	print(str(cost) + " : " + str(GLOBALVAR_PTD.money))
	if GLOBALVAR_PTD.money >= cost:
		get_node(towerPath).upgradeLevel2 += 1
		GLOBALVAR_PTD.money -= cost
		open()

func _on_texture_button3_pressed(): if get_node(towerPath).upgradeLevel3 < 3:
	var cost = GLOBALVAR_PTD.tower_upgrades[get_node(towerPath).towerName][3][get_node(towerPath).upgradeLevel3+1]["cost"]
	print(str(cost) + " : " + str(GLOBALVAR_PTD.money))
	if GLOBALVAR_PTD.money >= cost:
		get_node(towerPath).upgradeLevel3 += 1
		GLOBALVAR_PTD.money -= cost
		open()

func _process(delta): if visible:
	if GLOBALVAR_PTD.money >= int($upgrade1/cost.text):$upgrade1/Sprite2D.self_modulate=Color8(255,255,255)
	else:$upgrade1/Sprite2D.self_modulate=Color8(128,0,0)
	if GLOBALVAR_PTD.money >= int($upgrade2/cost.text):$upgrade2/Sprite2D.self_modulate=Color8(255,255,255)
	else:$upgrade2/Sprite2D.self_modulate=Color8(128,0,0)
	if GLOBALVAR_PTD.money >= int($upgrade3/cost.text):$upgrade3/Sprite2D.self_modulate=Color8(255,255,255)
	else:$upgrade3/Sprite2D.self_modulate=Color8(128,0,0)

func _on_sell_pressed():
	GLOBALVAR_PTD.money += get_node(towerPath).sellValue
	$sell/Sprite2D.play("default")
	
	hide()
	get_node(towerPath).queue_free()
