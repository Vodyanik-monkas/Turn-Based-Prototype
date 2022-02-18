extends Control

signal new_menu
signal new_turn
signal target_select
signal unselect_all
signal use_skill

var active_option = []

func _move_cursor(direction_x: int, direction_y: int):
	$MarginContainer/VBoxContainer/CombatDialogueBox.move_cursor(direction_x, direction_y)

func _new_menu(menu):
	emit_signal("new_menu", menu)

func _on_CombatDialogueBox_set_active_option(option: Dictionary):
	active_option = option

func _on_CommitAction_use_skill():
	emit_signal("use_skill", active_option)

func _on_SelectTarget_change_target(increment: int = 0):
	emit_signal(
		"target_select", 
		active_option["target"], 
		active_option["scope"], 
		increment)

func _on_SelectTarget_unselect_all():
	emit_signal("unselect_all")

func _option_selected():
	$StateMachine.change_to(active_option["next_state"])

func get_character_panel(character_index: int) -> Node:
	return $MarginContainer/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer.get_child(character_index)

func set_character_panel(index: int, stats: Node, portrait: Texture):
	var panel = get_character_panel(index)
	
	panel.set_health(stats.current_health, stats.max_health)
	panel.set_mana(stats.current_mana, stats.max_mana)
	panel.set_portrait(portrait)
	panel.show()

func set_combat_dialogue_box(options_list: Dictionary, menu: String, columns: int = 2):
	$MarginContainer/VBoxContainer/CombatDialogueBox.initialize_combat_dialogue_box(options_list, menu, columns)

func update_character_panel(element: String, index: int, current_resource: int, max_resource: int):
	var panel = get_character_panel(index)
	if element == "health":
		panel.set_health(current_resource, max_resource)
	if element == "mana":
		panel.set_mana(current_resource, max_resource)
