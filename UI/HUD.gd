extends Control

signal new_turn
signal toggle_skills_menu
signal target_select
signal unselect_all

var active_option = []

func set_character_panel(index: int, stats: Node, portrait: Texture):
	var panel = get_character_panel(index)
	
	panel.set_health(stats.current_health, stats.max_health)
	panel.set_mana(stats.current_mana, stats.max_mana)
	panel.set_portrait(portrait)
	panel.show()

func initialize_combat_dialogue_box(options_list: Dictionary):
	$MarginContainer/VBoxContainer/CombatDialogueBox.initialize_combat_dialogue_box(options_list)

func _move_cursor(direction_x: int, direction_y: int):
	$MarginContainer/VBoxContainer/CombatDialogueBox.move_cursor(direction_x, direction_y)

func _option_selected():
	$StateMachine.change_to(active_option["next_state"])

func _on_CombatDialogueBox_set_active_option(option: Dictionary):
	active_option = option

func get_character_panel(character_index: int) -> Node:
	return $MarginContainer/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer.get_child(character_index)

func _new_menu(is_on: bool):
	emit_signal("toggle_skills_menu", is_on)


func _on_SelectTarget_change_target(increment: int = 0):
	emit_signal(
		"target_select", 
		active_option["target"], 
		active_option["scope"], 
		increment)


func _on_SelectTarget_unselect_all():
	emit_signal("unselect_all")
