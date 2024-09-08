extends Node2D

func _draw():
	if get_parent().raycast_recent_pos != null:
		if get_parent().raycast_recent_pos:
			draw_line(get_node("../sprite").global_position, get_parent().raycast_recent_pos.global_position, Color8(255,0,0), 2)
			return
	draw_line(get_node("../sprite").global_position, get_node("../sprite").global_position, Color8(255,0,0), 2)

func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	queue_redraw()
