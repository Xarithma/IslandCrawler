extends Node

onready var nav_2d = get_owner().get_node("_nav")
onready var player = get_tree().get_nodes_in_group("Player")[0]

# * Testing
#onready var line_2d = get_parent().get_node("line_2d")

#func _unhandled_input(event: InputEvent) -> void:
#	if not event is InputEventMouseButton:
#		return
#	if event.button_index != BUTTON_LEFT or not event.pressed:
#		return
#
#	for enemy in get_tree().get_nodes_in_group("Enemies"):
#		var new_path = nav_2d.get_simple_path(enemy.global_position, event.position)
#		enemy.path = new_path
#		line_2d.points = new_path
# * Testing


func _process(_delta):
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		var new_path = nav_2d.get_simple_path(enemy.global_position, player.global_position)
		enemy.path = new_path
		# ! Showing the path for the main enemy.
		# ! line_2d.points = new_path
