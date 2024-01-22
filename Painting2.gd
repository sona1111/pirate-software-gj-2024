extends TileMap

@onready var player := get_parent().get_node("Player")


const cell_map = {
	'virus': Vector2i(12, 6),
	'virus_half': Vector2i(12, 6),
	'safe': Vector2i(0, 3),
}

var level_rect = null



func get_tiles_by_type(atlas_coords):
	var ret = []
	#var tile_id = get_tileset().find_tile_by_name(p_type)
	for cell in get_used_cells(0):		
		if get_cell_atlas_coords(0, cell) == atlas_coords:
			ret.append(cell)
	return ret
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_rect = $"../TileMap".get_used_rect()
	print("main", level_rect)
	print("overlay", get_used_rect())	
	$Timer.set_wait_time(5.0)
	$Timer.start()
	$Timer.connect("timeout", propogate_virus)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clean_at_point(player, 1)
	
func clean_at_point(object, radius):
	var cell_loc = local_to_map(object.position)	
	for dist in range(radius):
		if dist == 0:
			set_cell(0, cell_loc, 2, cell_map['safe'])
		else:
			set_cell(0, Vector2i(cell_loc.x, cell_loc.y + dist), 2, cell_map['safe'])
			set_cell(0, Vector2i(cell_loc.x, cell_loc.y - dist), 2, cell_map['safe'])
			set_cell(0, Vector2i(cell_loc.x + dist, cell_loc.y), 2, cell_map['safe'])
			set_cell(0, Vector2i(cell_loc.x - dist, cell_loc.y), 2, cell_map['safe'])
	
func propogate_virus():
	var overlay_rect = get_used_rect()
	for virus_cell in get_tiles_by_type(cell_map['virus']):
		var up = Vector2i(virus_cell.x, virus_cell.y + 1)
		var down = Vector2i(virus_cell.x, virus_cell.y - 1)
		var right = Vector2i(virus_cell.x + 1, virus_cell.y)
		var left = Vector2i(virus_cell.x - 1, virus_cell.y)
		
		if up.y < level_rect.end.y + overlay_rect.position.y:
			set_cell(0, up, 2, cell_map['virus'])
		if down.y >= level_rect.position.y + overlay_rect.position.y:
			set_cell(0, down, 2, cell_map['virus'])			
		if right.x < level_rect.end.x + overlay_rect.position.x:
			set_cell(0, right, 2, cell_map['virus'])
		if left.x >= level_rect.position.x + overlay_rect.position.x:
			set_cell(0, left, 2, cell_map['virus'])
		#if up.y < get

