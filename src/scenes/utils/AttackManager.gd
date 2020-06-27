extends Position2D

# export var is_friendly = true
export var is_player = true
export var is_anchored = false
export var attack_rate = 0.75
export var weapon_node = "res://scenes/weapons/WeaponTemplate.tscn"

var attack_direction = Vector2.ZERO
var can_attack = true

func _ready():
	if !is_player:
		set_process(false)

func _process(_delta):
	if attack_direction == Vector2.ZERO:
		return
	attack()

func attack():
	if !can_attack:
		return
	
	can_attack = false
	
	var attack = load(weapon_node).instance()
	attack.direction = attack_direction
	attack.is_friendly = is_player
	
	if is_anchored:
		add_child(attack)
	else:
		attack.position = global_position
		get_owner().get_owner().add_child(attack)
	
	yield(get_tree().create_timer(attack_rate), "timeout")
	can_attack = true

func _input(event):
	if !is_player:
		return
	attack_direction.x = event.get_action_strength("attack_right") - event.get_action_strength("attack_left")
	attack_direction.y = event.get_action_strength("attack_down") - event.get_action_strength("attack_up")
	attack_direction = attack_direction.normalized()
