extends Control

var positionInList = 0

func _process(_delta):
	if !get_node("../../upgrades").visible:
		for x in get_children():
			if x.visible:
				var y = x.find_child("bg")
				var c = x.find_child("cost")
				var buttonRect = Rect2(x.global_position, x.size)
				y.visible = buttonRect.has_point(get_global_mouse_position())
				if (GLOBALVAR_PTD.money >= int(c.text)): x.find_child("Sprite2D").self_modulate = Color8(255,255,255)
				else: x.find_child("Sprite2D").self_modulate = Color8(128,0,0)
			
			if x.posInList < positionInList or x.posInList > positionInList + 4: x.visible = false
			else: x.visible = true


func _on_scrollup_pressed():
	position.y -= 136
	positionInList += 1

func _on_scrolldown_pressed():
	position.y += 136
	positionInList -= 1
