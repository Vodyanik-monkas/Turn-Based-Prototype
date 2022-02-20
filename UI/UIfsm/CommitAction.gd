extends Node

signal use_skill

var fsm: StateMachine

func enter():
	emit_signal("use_skill")
	yield(get_tree().create_timer(0.75), "timeout")
	exit("EnemyTurn")

func exit(next_state):
	fsm.change_to(next_state)
