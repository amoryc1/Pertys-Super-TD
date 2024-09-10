extends Panel

var array_for_this_node = []

# Prevents the example node to be deleted cause idk what the hell is happening but something is wrong
func _on_trash_pressed(): if name != "example":
	print(get_node("../../../../../..").currentWaveArray[1])
	get_node("../../../../../..").currentWaveArray[get_node("../../../../../..").currentWave].erase(array_for_this_node)
	get_node("../../../../../..").updatePertyList()
	
	queue_free()


func _on_down_pressed() -> void:
	pass # Replace with function body.

func _on_up_pressed() -> void:
	pass # Replace with function body.
