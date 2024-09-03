extends Panel

var towerPath = ""

func update_text(child, upg, tower, tier):
	var updgLevel = get_node(towerPath).upgradeLevel1
	if child == "upgrade2": updgLevel = get_node(towerPath).upgradeLevel2
	if child == "upgrade3": updgLevel = get_node(towerPath).upgradeLevel3
	
	if updgLevel >= 3:
		get_node(child + "/title").text = "Max Level"
		get_node(child + "/cost").text  = "Max Level"
		get_node(child + "/desc").text = str(GLOBALVAR_PTD.towerUpgrades[tower.towerName][tier][3]["desc"])
		get_node(child + "/TextureButton").texture_normal = load("res://assets/towers/"+str(GLOBALVAR_PTD.towerUpgrades[tower.towerName][tier][3]["sprite"]))
	else:
		get_node(child + "/title").text = str(GLOBALVAR_PTD.towerUpgrades[tower.towerName][tier][upg+1]["name"])
		get_node(child + "/desc").text = str(GLOBALVAR_PTD.towerUpgrades[tower.towerName][tier][upg+1]["desc"])
		get_node(child + "/cost").text  = str(GLOBALVAR_PTD.towerUpgrades[tower.towerName][tier][upg+1]["cost"])
		get_node(child + "/TextureButton").texture_normal = load("res://assets/towers/"+str(GLOBALVAR_PTD.towerUpgrades[tower.towerName][tier][upg+1]["sprite"]))
	
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
	var cost = GLOBALVAR_PTD.towerUpgrades[get_node(towerPath).towerName][1][get_node(towerPath).upgradeLevel1+1]["cost"]
	print(str(cost) + " : " + str(GLOBALVAR_PTD.money))
	if GLOBALVAR_PTD.money >= cost:
		get_node(towerPath).upgradeLevel1 += 1
		GLOBALVAR_PTD.money -= cost
		update_text("upgrade1", get_node(towerPath).upgradeLevel1, get_node(towerPath), 1)

func _on_texture_button2_pressed(): if get_node(towerPath).upgradeLevel2 < 3:
	var cost = GLOBALVAR_PTD.towerUpgrades[get_node(towerPath).towerName][2][get_node(towerPath).upgradeLevel2+1]["cost"]
	print(str(cost) + " : " + str(GLOBALVAR_PTD.money))
	if GLOBALVAR_PTD.money >= cost:
		get_node(towerPath).upgradeLevel2 += 1
		GLOBALVAR_PTD.money -= cost
		update_text("upgrade2", get_node(towerPath).upgradeLevel2, get_node(towerPath), 2)

func _on_texture_button3_pressed(): if get_node(towerPath).upgradeLevel3 < 3:
	var cost = GLOBALVAR_PTD.towerUpgrades[get_node(towerPath).towerName][3][get_node(towerPath).upgradeLevel3+1]["cost"]
	print(str(cost) + " : " + str(GLOBALVAR_PTD.money))
	if GLOBALVAR_PTD.money >= cost:
		get_node(towerPath).upgradeLevel3 += 1
		GLOBALVAR_PTD.money -= cost
		update_text("upgrade3", get_node(towerPath).upgradeLevel3, get_node(towerPath), 3)

func _process(delta): if visible:
	if GLOBALVAR_PTD.money >= int($upgrade1/cost.text):$upgrade1/TextureButton.self_modulate=Color8(255,255,255)
	else:$upgrade1/TextureButton.self_modulate=Color8(128,0,0)
	if GLOBALVAR_PTD.money >= int($upgrade2/cost.text):$upgrade2/TextureButton.self_modulate=Color8(255,255,255)
	else:$upgrade2/TextureButton.self_modulate=Color8(128,0,0)
	if GLOBALVAR_PTD.money >= int($upgrade3/cost.text):$upgrade3/TextureButton.self_modulate=Color8(255,255,255)
	else:$upgrade3/TextureButton.self_modulate=Color8(128,0,0)

func _on_sell_pressed():
	GLOBALVAR_PTD.money += get_node(towerPath).sellValue
	$sell/Sprite2D.play("default")
	
	hide()
	get_node(towerPath).queue_free()
