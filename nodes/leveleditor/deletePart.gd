extends Panel


# Prevents the example node to be deleted cause idk what the hell is happening but something is wrong
func _on_trash_pressed(): if name != "example":
	var i = int($id.text)
	var j = int($wavenumber.text)
	
	# Erase this bit from the array
	get_node("../../../..").currentWaveArray[j].remove_at(i)
	
	name = "_Hey_ Good job looking at my code! Have you gouged your eyes out yet?_"
	# Remove the bit in the list
	
	get_node("../../../..").updatePertyListOnDelete(i)
	
	queue_free()
