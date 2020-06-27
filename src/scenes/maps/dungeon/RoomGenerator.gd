extends Position2D

# Top, bot, left, right.
export var opening_direction = 0

func _ready():
	set_process(false)
	room_position_check()

func _process(_delta):
	generate_room()
	set_process(false)

# Convert this into just listing rooms
func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif !file.begins_with("."):
			if file.has("Top"):
				files.append(file)
			
	dir.list_dir_end()

func generate_room():
	match opening_direction:
		1: # Spawn top room
			add_child(load(room_manager.top_rooms[randi() % room_manager.top_rooms.size()]).instance())
		2: # Spawn bot room
			add_child(load(room_manager.bot_rooms[randi() % room_manager.bot_rooms.size()]).instance())
		3: # Spawn left room
			add_child(load(room_manager.left_rooms[randi() % room_manager.left_rooms.size()]).instance())
		4: # Spawn right room
			add_child(load(room_manager.right_rooms[randi() % room_manager.right_rooms.size()]).instance())

func room_position_check():
	if opening_direction == 0 || room_manager.rooms.has(global_position):
		return
	room_manager.rooms.append(global_position)
	randomize()
	set_process(true)
