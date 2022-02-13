extends Node
var fsm: StateMachine

signal change_target
signal select_target
signal unselect_all

func enter():
	emit_signal("change_target")

func exit(next_state):
	fsm.change_to(next_state)

func unhandled_input(event):	
	if (Input.is_action_just_pressed("ui_down") or
	Input.is_action_just_pressed("ui_right")):
		emit_signal("change_target", 1)
	if (Input.is_action_just_pressed("ui_up") or
	Input.is_action_just_pressed("ui_left")):
		emit_signal("change_target", -1)
	
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("select_target")
	
	if Input.is_action_just_pressed("ui_cancel"):
		emit_signal("unselect_all")
		fsm.back()
