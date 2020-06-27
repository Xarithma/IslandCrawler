extends Node2D

export var expire = 0.67
export var damage = 1
export var action_speed = 175
export var size_multiplier = 1

var movement = Vector2.ZERO
var is_friendly = null
var direction = null

func _ready():
	yield(get_tree().create_timer(expire), "timeout")
	queue_free()

func _physics_process(delta):
	projectile_move(delta)

func projectile_move(delta):
	movement = direction * delta * action_speed
	translate(movement)
	movement.normalized()

func _on_Weapon_area_entered(area):
	pass # Replace with function body.
