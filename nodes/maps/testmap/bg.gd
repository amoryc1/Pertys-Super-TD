extends TileMap

var path_tile_id = Vector2i(0, 13)  # Replace with your specific tile ID

func _ready():
	set_process(true)

func _process(delta):
	# Get the mouse position in the TileMap's coordinate system
	var tile_pos = local_to_map(get_global_mouse_position())/2
