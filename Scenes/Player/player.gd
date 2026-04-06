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


func setup() -> void:
# Initializes the player's runtime state. This should be called once when the player
# is created or when the player is respawned.
#
# What it does:
# - Resets the player's health to max and emits a health update event.
# - Resets the player's mana to max and emits a mana update event.
#
# Additional initialization (animation, FSM start, inventory, etc.) can be added here.
# Reset health and notify listeners via EventBus
reset_health()
# Reset mana and notify listeners via EventBus
reset_mana()



func reset_health() -> void:
	health_component.setup(max_health)
	EventBus.on_player_health_updated.emit(max_health, max_health)


func reset_mana() -> void:
	current_mana = max_mana
	EventBus.on_player_mana_updated.emit(max_mana, max_mana)


func use_mana(value: float) -> void:
	current_mana -= max(current_mana - value, 0)
	EventBus.on_player_mana_updated.emit(current_mana, max_mana)


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
