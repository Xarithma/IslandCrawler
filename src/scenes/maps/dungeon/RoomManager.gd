extends Node

var rooms = [
	Vector2(0, 0)
]

var last_room_array_size = rooms.size()

var top_rooms = []
var bot_rooms = []
var left_rooms = []
var right_rooms = []

# Convert this into just listing rooms
func get_rooms_array():
	var dir = Directory.new()
	var path = "res://scenes/maps/dungeon/rooms/"
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif !file.begins_with("."):
			if "Top" in file:
				top_rooms.append(path + file)
			if "Bot" in file:
				bot_rooms.append(path + file)
			if "Left" in file:
				left_rooms.append(path + file)
			if "Right" in file:
				right_rooms.append(path + file)
	dir.list_dir_end()

func _ready():
	get_rooms_array()

func _process(_delta):
	spawn_floor_boss()
	set_process(false)

func spawn_floor_boss():
	yield(get_tree().create_timer(5), "timeout")
	print("Boss spawned on ", rooms.back())
