class_name StateMachine extends Node

@export var initial_state: State

signal on_state_transitioned(new_state: String)

var current_state: State


func _ready() -> void:
	await owner.ready
	for child: State in get_children():
		child.state_machine = self

	current_state = initial_state
	current_state.enter_state()


func transition_to(state: String) -> void:
	if not has_node(state):
		return

	current_state.exit_state()
	current_state = get_node(state)
	current_state.enter_state()

	on_state_transitioned.emit(current_state.name)
