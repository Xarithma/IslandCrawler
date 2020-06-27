extends KinematicBody2D

var path = PoolVector2Array() setget set_path

export var speed = 50
export var health = 2

onready var max_health = health

onready var animTree = $anim_tree
onready var animState = animTree.get("parameters/playback")

func _ready():
	set_process(false)

func _process(_delta):
	health_handle()

func _physics_process(delta):
	var move_distance = speed * delta
	
	move_along_path(move_distance)
	animate(Vector2(0, 1))

func move_along_path(distance):
	var last_point = position
	for _i in range(path.size()):
		var distance_to_next = last_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0:
			position = last_point.linear_interpolate(path[0], distance / distance_to_next)
			# ? move_and_collide(Vector2(0.0, 0.0)) Should I even use this?
			break
		elif path.size() == 1 and distance >= distance_to_next:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		last_point = path[0]
		path.remove(0)

func animate(vector):
	animTree.set("parameters/Idle/blend_position", vector)
	animTree.set("parameters/Move/blend_position", vector)
	animState.travel("Move")

func set_path(value):
	if value.size() == 0:
		return
	path = value
	path.remove(0)
	set_process(true)

func health_handle():
	if health <= 0:
		queue_free()
	elif health > max_health:
		health = max_health

func health_adjust(value):
	health -= value
