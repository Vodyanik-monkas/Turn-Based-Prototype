extends HBoxContainer

signal set_active_option

func initialize_combat_dialogue_box(options_list: Dictionary, menu: String, columns: int):
	$OptionPanel/Margins/OptionMenu.initialize_option_menu(options_list, menu, columns)

func move_cursor(direction_x: int, direction_y: int):
	$OptionPanel/Margins/OptionMenu.move_cursor(direction_x, direction_y)

func get_hovered_option() -> Dictionary:
	return $OptionPanel/Margins/OptionMenu.get_hovered_button_dictionary()

func _on_OptionMenu_active_option(id: Dictionary):
	emit_signal("set_active_option", id)

func _on_OptionMenu_set_tooltip(tooltip):
	$ToolTip.set_tooltip(tooltip)
