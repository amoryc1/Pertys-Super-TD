extends Panel

var currentPathVis = 0

func updateUpgrades():
	get_node("upgrades/1").visible = false
	get_node("upgrades/2").visible = false
	get_node("upgrades/3").visible = false
	
	get_node("upgrades/" + str(currentPathVis)).visible = true

func _input(event: InputEvent) -> void:
	if get_node("../../../").visible:
		# Check if the event is a mouse button press
		if event is InputEventMouseButton and event.pressed:
			# Get the position of the mouse click
			if get_node("pathup").get_rect().has_point(get_local_mouse_position()):
				print("u")
				currentPathVis += 1
				if currentPathVis == 4: currentPathVis = 1
				updateUpgrades()
			if get_node("pathdown").get_rect().has_point(get_local_mouse_position()):
				print("d")
				currentPathVis -= 1
				if currentPathVis == -1: currentPathVis = 3
				updateUpgrades()
