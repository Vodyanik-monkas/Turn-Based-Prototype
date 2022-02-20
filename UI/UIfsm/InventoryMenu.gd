extends Node

var fsm: StateMachine

func enter():
	print("Hello from InventoryMenu")

func exit(next_state):
	fsm.change_to(next_state)
