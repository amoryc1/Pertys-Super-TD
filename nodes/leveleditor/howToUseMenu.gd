extends Panel

var maxPage = 9
var currentPage = 1

func _ready():
	$page1/pertyTalking.play("default")


func updatePage():
	$pageNumber.text = str(currentPage)
	
	for n in maxPage: # if maxPage = 5 then (0,1,2,3,4 so +1 fixes that)
		find_child("page" + str(n+1)).hide()
		get_node("page" + str(n+1) + "/pertyTalking").stop()
		
	find_child("page" + str(currentPage)).show()
	get_node("page" + str(currentPage) + "/pertyTalking").play("default")

func _on_left_pressed():
	if currentPage == 1: currentPage = maxPage
	else: currentPage -= 1
	
	get_node("../../sfx/clickSFX").play()
	updatePage()

func _on_right_pressed():
	if currentPage == maxPage: currentPage = 1
	else: currentPage += 1
	
	get_node("../../sfx/clickSFX").play()
	updatePage()
