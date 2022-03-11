extends Node

signal enemy_turn

var fsm: StateMachine

func enter():
	emit_signal("enemy_turn")

func exit(next_state):
	fsm.change_to(next_state)
