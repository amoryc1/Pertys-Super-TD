extends CanvasLayer


func _process(_delta):
	$stats/health.text = str(GLOBALVAR_PTD.health)
	$stats/moneys.text = GLOBALVAR_PTD.format_with_commas(GLOBALVAR_PTD.money)
	$stats/wave.text = "Wave "+str(get_node("../enemyspawner").wave)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("f1"): visible = !visible

func _on_startwave_pressed():
	GLOBALVAR_PTD.in_wave = true
	get_node("../enemyspawner").spawningEnemy = true
	$startwave.disabled = true
	
	var estT = 0
	var array = get_node("../").levelStats[get_node("../enemyspawner").wave]
	print(array)
	for x in array:
		estT += (x[2] * x[1])

	GLOBALVAR_PTD.estimated_time_for_spawns = estT
