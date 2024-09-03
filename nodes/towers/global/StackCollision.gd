extends Area2D

var mouseIn = false
func _mouse_enter(): if get_parent().active:
	get_node("../ring").visible = true
	mouseIn = true

func _mouse_exit(): if get_parent().active:
	get_node("../ring").visible = false
	mouseIn = false

func _input(event):
	# When left mouse button clicks over the collision box open the upgrades
	if event is InputEventMouseButton: 
		if event.button_index == 1 and mouseIn and get_parent().active and get_parent().canUpgrade:
			get_node("../../../LevelUI/upgrades/towerID").text = get_parent().towerName
			get_node("../../../LevelUI/upgrades").visible = true
			get_node("../../../LevelUI/upgrades").towerPath = get_node("..").get_path()
			get_node("../../../LevelUI/upgrades").open()
