extends Node

signal use_skill

var fsm: StateMachine

func enter():
	emit_signal("use_skill")

func exit(next_state):
	fsm.change_to(next_state)
