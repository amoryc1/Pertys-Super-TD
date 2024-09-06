extends Area2D

var mouseIn = false
func _mouse_enter(): if get_parent().active:
	get_node("../ring").visible = true
	mouseIn = true
	GLOBALVAR_PTD.mouse_hover_stack_collision += 1

func _mouse_exit(): if get_parent().active:
	get_node("../ring").visible = false
	mouseIn = false
	GLOBALVAR_PTD.mouse_hover_stack_collision -= 1

func _input(event):
	# When left mouse button clicks over the collision box open the upgrades
	if Input.is_action_just_pressed("MouseLeft"): 
		if mouseIn and get_parent().active and get_parent().canUpgrade:
			get_node("../../../LevelUI/upgrades/towerID").text = get_parent().towerName
			get_node("../../../LevelUI/upgrades").visible = true
			get_node("../../../LevelUI/upgrades").towerPath = get_node("..").get_path()
			get_node("../../../LevelUI/upgrades").open()


func _on_body_entered(body) -> void:
	if body.get_parent().name == "obstacles":
		if !body.can_spawn_on: GLOBALVAR_PTD.mouse_hover_stack_collision -= 1

func _on_body_exited(body) -> void:
	if body.get_parent().name == "obstacles":
		if !body.can_spawn_on: GLOBALVAR_PTD.mouse_hover_stack_collision += 1


func _on_area_entered(area: Area2D) -> void:
	if area.name == "StackCollision":
		GLOBALVAR_PTD.mouse_hover_stack_collision -= 1

func _on_area_exited(area: Area2D) -> void:
	if area.name == "StackCollision":
		GLOBALVAR_PTD.mouse_hover_stack_collision += 1
