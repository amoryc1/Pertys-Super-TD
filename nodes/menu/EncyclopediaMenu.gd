extends Panel

var upgrade_vis = {
}

func _on_close_pressed(): visible = false ; get_node("../tapSFX").play() ; GLOBALVAR_PTD.show_exp_bar = true

func _ready():
	# Get all tower names from placedTower dict and put em in updgradeVis
	for x in GLOBALVAR_PTD.placed_towers.keys():
		upgrade_vis[x] = 1

func updateList(what):
	if what == "Tower":
		for x in $towerslist/ScrollContainer/VBoxContainer.get_children():
			if x.name != "blank":
				var branchID = 0
				var tierID = 0
				var towername = x.name
				var towernamenode = "towerslist/ScrollContainer/VBoxContainer/" + towername
				get_node(towernamenode + "/title").text = towername + " (" + str(GLOBALVAR_PTD.placed_towers[towername]) + " Placed)"
				var upgradearray = GLOBALVAR_PTD.tower_upgrades[towername]
				
				# Loop upgrades 
				while branchID < 3:
					branchID += 1
					tierID = 0
					while tierID < 3:
						tierID += 1
						var nodepath = get_node(towernamenode + "/upgrades/" + str(branchID) + "/" + str(tierID))
						nodepath.find_child("Sprite2D").texture = load("res://assets/towers/" + GLOBALVAR_PTD.tower_upgrades[towername][branchID][tierID]["sprite"])
						nodepath.find_child("Sprite2D").frame = GLOBALVAR_PTD.tower_upgrades[towername][branchID][tierID]["spriteFrame"]
						nodepath.find_child("title").text = GLOBALVAR_PTD.tower_upgrades[towername][branchID][tierID]["name"] + " (" + str(GLOBALVAR_PTD.tower_upgrades[towername][branchID][tierID]["cost"]) + ")"
						nodepath.find_child("desc").text = GLOBALVAR_PTD.tower_upgrades[towername][branchID][tierID]["desc"]



func _on_pathup_pressed(P):
	if upgrade_vis[P] == 3: upgrade_vis[P] = 1
	else: upgrade_vis[P] += 1
	
	get_node("../snas").pitch_scale = 1 + (0.1 * (upgrade_vis[P]-1))
	get_node("../snas").play()
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/1").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/2").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/3").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/"+str(upgrade_vis[P])).visible = true


func _on_pathdown_pressed(P):
	if upgrade_vis[P] == 1: upgrade_vis[P] = 3
	else: upgrade_vis[P] -= 1
	
	get_node("../snas").pitch_scale = 1 + (0.1 * (upgrade_vis[P]-1))
	get_node("../snas").play()
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/1").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/2").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/3").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/"+str(upgrade_vis[P])).visible = true


func _on_towers_pressed(extra_arg_0: String) -> void:
	$towerslist.visible = false
	$pertylist.visible = false
	$statuslist.visible = false
	find_child(extra_arg_0).visible = true
