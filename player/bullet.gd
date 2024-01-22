class_name Bullet
extends RigidBody2D

var disabled = false
@onready var painting2 := get_parent().get_node("TileMap2")

func _ready():
	($Timer as Timer).start()


func disable():
	if disabled:
		return

	($AnimationPlayer as AnimationPlayer).play("shutdown")
	disabled = true

func _process(delta: float) -> void:
	painting2.clean_at_point(self, 2)
	
