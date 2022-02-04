extends Node

signal ready_for_character_skills

var fsm: StateMachine

func enter():
	print("Hello from OpenSkills")
	emit_signal("ready_for_character_skills")
	exit("PlayerChoice")

func exit(next_state):
	fsm.change_to(next_state)
