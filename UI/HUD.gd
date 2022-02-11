extends Control

signal new_turn

var active_option = "empty"
var turn = 0

func set_character_panel(index: int, stats: Node, portrait: Texture):
	var panel = get_character_panel(index)
	
	panel.set_health(stats.current_health, stats.max_health)
	panel.set_mana(stats.current_mana, stats.max_mana)
	panel.set_portrait(portrait)
	panel.show()

func initialize_combat_dialogue_box(options_list):
	$MarginContainer/VBoxContainer/CombatDialogueBox.initialize_combat_dialogue_box(options_list)

func _on_PlayerChoice_move_cursor(direction_x, direction_y):
	$MarginContainer/VBoxContainer/CombatDialogueBox.move_cursor(direction_x, direction_y)

func _on_CombatDialogueBox_set_active_option(id):
	active_option = id

func _on_PlayerChoice_option_selected():
	pass # Replace with function body.

func get_character_panel(character_index) -> Node:
	return $MarginContainer/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer.get_child(character_index)
