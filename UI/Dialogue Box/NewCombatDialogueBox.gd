extends HBoxContainer

signal set_active_option

func initialize_combat_dialogue_box(options_list):
	$ToolTipBox/MarginContainer/OptionMenu.initialize_option_menu(options_list)

func move_cursor(direction_x: int, direction_y: int):
	$ToolTipBox/MarginContainer/OptionMenu.move_cursor(direction_x, direction_y)

func _on_OptionMenu_active_option(id: Dictionary):
	emit_signal("set_active_option", id)

func _on_OptionMenu_set_tooltip(tooltip):
	$ToolTip.set_tooltip(tooltip)
