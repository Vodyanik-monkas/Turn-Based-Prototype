extends Control

signal new_turn

var active_option = "empty"
var turn = 0

func _ready():
	emit_signal("new_turn", turn)

func set_character_health(character_index, current_health, max_health):
	pass

func set_character_mana(character_index, current_mana, max_mana):
	pass

func set_character_portrait(character_index):
	pass

func initialize_combat_dialogue_box(options_list):
	$MarginContainer/VBoxContainer/CombatDialogueBox.initialize_combat_dialogue_box(options_list)

func _on_PlayerChoice_move_cursor(direction_x, direction_y):
	$MarginContainer/VBoxContainer/CombatDialogueBox.move_cursor(direction_x, direction_y)

func _on_CombatDialogueBox_set_active_option(id):
	active_option = id

func _on_PlayerChoice_option_selected():
	pass # Replace with function body.
