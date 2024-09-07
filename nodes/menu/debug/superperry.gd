extends Node2D


var enemyNode = preload("res://nodes/enemies/Perty.tscn")

func _ready() -> void: get_parent().visible = GLOBALVAR_PTD.show_debug

func _unhandled_key_input(event: InputEvent) -> void: get_parent().visible = GLOBALVAR_PTD.show_debug


func _on_show_pressed():
	var listNode = get_node("../list")
	if listNode.visible: listNode.visible = false ; get_node("../show").rotation_degrees = 180
	else: listNode.visible = true ; get_node("../show").rotation_degrees = 0


func _on_moneys_pressed():
	GLOBALVAR_PTD.money += 100000


func _on_win_pressed():
	get_node("../../../enemyspawner").end_game(true)

func _on_loss_pressed():
	get_node("../../../enemyspawner").end_game(false)
