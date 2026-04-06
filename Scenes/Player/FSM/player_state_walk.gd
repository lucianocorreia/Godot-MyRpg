class_name PlayerStateWalk
extends PlayerState


func enter_state() -> void:
	player.play_direction_animation("walk")


func process_state(_delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector == Vector2.ZERO:
		state_machine.transition_to("Idle")
		return

	player.update_direction(input_vector)
	player.play_direction_animation("walk")

	player.velocity = input_vector * player.move_speed
	player.move_and_slide()
