extends HBoxContainer

signal set_active_option

func set_combat_dialogue_box(options_list: Dictionary, menu: String, available_mana: int) -> void:
	$OptionPanel/Margins/OptionMenu.set_option_menu(options_list, menu, available_mana)

func move_cursor(direction_x: int, direction_y: int) -> void:
	$OptionPanel/Margins/OptionMenu.move_cursor(direction_x, direction_y)

func get_hovered_option() -> Dictionary:
	return $OptionPanel/Margins/OptionMenu.get_hovered_button_dictionary()

func _on_OptionMenu_active_option(id: Dictionary) -> void:
	emit_signal("set_active_option", id)

func _on_OptionMenu_set_tooltip(tooltip) -> void:
	$ToolTip.set_tooltip(tooltip)
