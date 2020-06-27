extends Area2D

export (PackedScene) var object_to_spawn
# export var distance_between_objects = 10

onready var col = $Collision

# I'm gonna be very fricking honest with you.
# I don't know why would I use this...
# ! Remove!
func _ready():
	randomize()

	var size = col.shape.extents
	var pos_in_area = Vector2.ZERO

	pos_in_area.x = rand_range(size.x, -size.x)
	pos_in_area.y = rand_range(size.y, -size.y)

	var object = object_to_spawn.instance()
	object.position = pos_in_area
	add_child(object)
