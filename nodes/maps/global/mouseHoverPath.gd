extends TileMap

@export var pathDataCoords = Vector2i(0, 1) # Where the path image is inside the tilemap
@export var waterDataCoords = Vector2i(0, 2)
func _input(_event):
	# Get mouse pos and convert it to the tilemap pos
	var tile_pos = local_to_map(get_global_mouse_position())/2
	if get_cell_atlas_coords(0, tile_pos) == pathDataCoords: GLOBALVAR_PTD.mouseHoverOverPath = true
	else: GLOBALVAR_PTD.mouseHoverOverPath = false
	
	if get_cell_atlas_coords(0, tile_pos) == waterDataCoords: GLOBALVAR_PTD.mouseHoverOverWater = true
	else: GLOBALVAR_PTD.mouseHoverOverWater = false
