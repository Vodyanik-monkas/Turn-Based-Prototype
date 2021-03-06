extends Control

func move_cursor(direction_x: int, direction_y: int) -> void:
	$MarginContainer/VBoxContainer/CombatDialogueBox.move_cursor(direction_x, direction_y)

func get_character_panel(character_index: int) -> Node:
	return $MarginContainer/VBoxContainer/NinePatchRect/MarginContainer/VBoxContainer.get_child(character_index)

func get_hovered_option() -> Dictionary:
	return $MarginContainer/VBoxContainer/CombatDialogueBox.get_hovered_option()

func set_character_panel(index: int, stats: Node, portrait: Texture) -> void:
	var panel = get_character_panel(index)
	
	panel.set_health(stats.current_health, stats.max_health)
	panel.set_mana(stats.current_mana, stats.max_mana)
	panel.set_portrait(portrait)
	panel.show()

func set_combat_dialogue_box(options_list: Dictionary, menu: String, available_mana: int = 0) -> void:
	$MarginContainer/VBoxContainer/CombatDialogueBox.set_combat_dialogue_box(options_list, menu, available_mana)

func update_character_panel(element: String, index: int, current_resource: int, max_resource: int) -> void:
	var panel = get_character_panel(index)
	if element == "health":
		panel.set_health(current_resource, max_resource)
	if element == "mana":
		panel.set_mana(current_resource, max_resource)
