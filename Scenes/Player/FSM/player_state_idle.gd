class_name PlaterStateIdle
extends PlayerState


func enter_state() -> void:
	player.play_direction_animation("idle")


func process_state(_delta: float) -> void:
	if player.is__moving():
		state_machine.transition_to("Walk")
