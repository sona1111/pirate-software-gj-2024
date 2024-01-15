extends TileMap

@onready var player := get_parent().get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var cell_loc = local_to_map(player.position)
	print(cell_loc)
	set_cell(0, cell_loc, 2, Vector2i(0, 3))
