extends Node

signal toggle_skills

var fsm: StateMachine

var is_skills_showing : bool = false

func enter():
	is_skills_showing = not is_skills_showing
	emit_signal("toggle_skills", is_skills_showing)
	exit("PlayerChoice")

func exit(next_state):
	fsm.change_to(next_state)
