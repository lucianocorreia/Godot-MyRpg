class_name Player extends CharacterBody2D

@export var max_health: float = 10.0
@export var max_mana: float = 10.0
@export var move_speed: float = 10.0
@export var damage: float = 10.0
@export var crit_chance: float = 10.0
@export var crit_damage: float = 10.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm: StateMachine = $FSM

var last_direction: String = "down"


func _process(delta: float):
	fsm.current_state.process_state(delta)


func is__moving() -> bool:
	var move_input = ["move_down", "move_up", "move_left", "move_right"]
	for input in move_input:
		if Input.is_action_pressed(input):
			return true
	return false


func update_direction(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:
		return

	if abs(input_vector.x) > abs(input_vector.y):
		last_direction = "right" if input_vector.x > 0 else "left"
	else:
		last_direction = "down" if input_vector.y > 0 else "up"


func play_direction_animation(anim_name: String) -> void:
	anim_sprite.play("%s_%s" % [anim_name, last_direction])
