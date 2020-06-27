extends KinematicBody2D

# Movement variable for the script.
var velocity = Vector2.ZERO
const ACCELERATION = 1000
const MAX_SPEED = 150
const FRICTION = 1500 # ! Think about replacing this to ACCELERATION * 1.5 pls

# Variable for the character's health.
var health = 5
onready var max_health = health

# Animation variable to be controlled by script.
onready var animTree = $_anim_tree
onready var animState = animTree.get("parameters/playback")

onready var camera = get_tree().get_nodes_in_group("Cam")[0]

# Movement direction.
var move_vector = Vector2.ZERO

# Stuff that runs every frame.
func _process(_delta):
	get_input()
	health_handle()

# Stuff that runs 60 times per second.
func _physics_process(delta):
	move_and_animate(delta)
	move_camera(delta)

# Gets the input (called in _process)
func get_input():
	move_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_vector = move_vector.normalized()

# Sets up animation along the movement (uses move and slide and called in _physics_process).
func move_and_animate(delta):
	if move_vector != Vector2.ZERO:
		velocity = velocity.move_toward(move_vector * MAX_SPEED, ACCELERATION * delta)
		
		animTree.set("parameters/Idle/blend_position", move_vector)
		animTree.set("parameters/Move/blend_position", move_vector)
		animState.travel("Move")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animState.travel("Idle")
		
	velocity = move_and_slide(velocity)
	

func move_camera(delta):
	var closest_room = room_manager.rooms[0]
	for i in range(room_manager.rooms.size()):
		if global_position.distance_to(room_manager.rooms[i]) < global_position.distance_to(closest_room):
			closest_room = room_manager.rooms[i]
	camera.global_position = camera.global_position.linear_interpolate(closest_room, delta * 10)

# Controlls the character's health system. (Called in _process.)
func health_handle():
	if health <= 0:
		queue_free() # ! Game over screen, and death animation!
	elif health > max_health:
		health = max_health

# Adjusts the player health by a value. (Called in other scripts.)
func health_adjust(value):
	health -= value
