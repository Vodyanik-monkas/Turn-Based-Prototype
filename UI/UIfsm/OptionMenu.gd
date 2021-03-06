extends Node

signal move_cursor
signal option_selected
signal new_menu

var fsm: StateMachine

func enter():
	emit_signal("new_menu", "option")

func exit(next_state):
	fsm.change_to(next_state)

func unhandled_input(_event):
	if Input.is_action_just_pressed("ui_up"):
		emit_signal("move_cursor", Vector2(0, -1))
	if Input.is_action_just_pressed("ui_down"):
		emit_signal("move_cursor", Vector2(0, 1))
	if Input.is_action_just_pressed("ui_left"):
		emit_signal("move_cursor", Vector2(-1, 0))
	if Input.is_action_just_pressed("ui_right"):
		emit_signal("move_cursor", Vector2(1, 0))
	
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("option_selected")
	
	if Input.is_action_just_pressed("ui_cancel"):
		fsm.back()
