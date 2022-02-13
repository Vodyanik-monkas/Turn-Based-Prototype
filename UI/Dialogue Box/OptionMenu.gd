extends HBoxContainer

signal active_option
signal set_tooltip

export(PackedScene) var option_buttons

var options = []

# Starting cursor position in Options list
export var cursor_position_x = 0
export var cursor_position_y = 0

var col_count = 2

func initialize_option_menu(character_options):
	options = character_options
	col_count = get_child_count()
	
	draw_options()
	emit_signal("set_tooltip", get_action_tooltip())

# Changes which option is focused on
func move_cursor(direction_x, direction_y):
	if options.size() == 0:
		return 1
	
	get_selected_option().set_cursor_inactive()
	
	cursor_position_x += direction_x
	cursor_position_y += direction_y
	
	# Prevents the cursor from going out of bounds
	cursor_position_x = clamp(cursor_position_x, 0, col_count - 1)
	cursor_position_y = clamp(cursor_position_y, 0, get_options_in_column())
	
	emit_signal("active_option", options[get_selected_option().id])
	emit_signal("set_tooltip", get_action_tooltip())
	
	get_selected_option().set_cursor_active()

# Instances options and places them
func draw_options():
	reset_cursor_position()
	
	var index = 0
	for option in options:
		var action = option_buttons.instance()
		action.id = option
		
		get_child(index % col_count).add_child(action)
		
		if index == 0:
			# queue_free() is called on old options, but certain functions
			# break if they're called in the same frame as queue free
			# changing the id of the queued object fixes that
			get_selected_option().id = option
			
			emit_signal("active_option", options[option])
			action.set_cursor_active()
		
		index += 1

func get_selected_option():
	return get_child(cursor_position_x).get_child(cursor_position_y)

func get_options_in_column():
	return get_child(cursor_position_x).get_child_count() - 1

func reset_cursor_position():
	cursor_position_x = 0
	cursor_position_y = 0

func get_action_tooltip():
	return options[get_selected_option().id]["tooltip"]
