extends Panel

var upgradeVis = {
}

func _on_close_pressed(): visible = false ; get_node("../tapSFX").play()

func _ready():
	# Get all tower names from placedTower dict and put em in updgradeVis
	for x in GLOBALVAR_PTD.placedTowers.keys():
		upgradeVis[x] = 1

func updateList(what):
	if what == "Tower":
		for x in $towerslist/ScrollContainer/VBoxContainer.get_children():
			if x.name != "blank":
				var branchID = 0
				var tierID = 0
				var towername = x.name
				var towernamenode = "towerslist/ScrollContainer/VBoxContainer/" + towername
				get_node(towernamenode + "/title").text = towername + " (" + str(GLOBALVAR_PTD.placedTowers[towername]) + " Placed)"
				var upgradearray = GLOBALVAR_PTD.towerUpgrades[towername]
				
				# Loop upgrades 
				while branchID < 3:
					branchID += 1
					tierID = 0
					while tierID < 3:
						tierID += 1
						var nodepath = get_node(towernamenode + "/upgrades/" + str(branchID) + "/" + str(tierID))
						nodepath.find_child("Sprite2D").texture = load("res://assets/towers/" + GLOBALVAR_PTD.towerUpgrades[towername][branchID][tierID]["sprite"])
						nodepath.find_child("title").text = GLOBALVAR_PTD.towerUpgrades[towername][branchID][tierID]["name"] + " (" + str(GLOBALVAR_PTD.towerUpgrades[towername][branchID][tierID]["cost"]) + ")"
						nodepath.find_child("desc").text = GLOBALVAR_PTD.towerUpgrades[towername][branchID][tierID]["desc"]



func _on_pathup_pressed(P):
	get_node("../snas").play()
	if upgradeVis[P] == 3: upgradeVis[P] = 1
	else: upgradeVis[P] += 1
	
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/1").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/2").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/3").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/"+str(upgradeVis[P])).visible = true


func _on_pathdown_pressed(P):
	get_node("../snas").play()
	if upgradeVis[P] == 1: upgradeVis[P] = 3
	else: upgradeVis[P] -= 1
	
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/1").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/2").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/3").visible = false
	get_node("towerslist/ScrollContainer/VBoxContainer/"+P+"/upgrades/"+str(upgradeVis[P])).visible = true
