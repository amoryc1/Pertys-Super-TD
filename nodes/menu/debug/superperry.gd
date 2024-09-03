extends Node2D


var enemyNode = preload("res://nodes/enemies/Perty.tscn")

func _on_show_pressed():
	var listNode = get_node("../list")
	if listNode.visible: listNode.visible = false ; get_node("../show").rotation_degrees = 180
	else: listNode.visible = true ; get_node("../show").rotation_degrees = 0


func _on_moneys_pressed():
	GLOBALVAR_PTD.money += 100000
	

func _on_win_pressed():
	GLOBALVAR_PTD.win_game(get_node("../../../").levelStats[0]["difficulty"], get_node("../../../").levelStats[0]["levelName"])

func _on_loss_pressed():
	GLOBALVAR_PTD.health = 0
