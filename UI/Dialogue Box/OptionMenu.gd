extends HBoxContainer

signal active_option
signal set_tooltip

export(PackedScene) var option_buttons

var options = []

var active_menu = "option"

var cursor_positions = {
	"item": Vector2(0,0),
	"option": Vector2(0,0),
	"skill": Vector2(0,0)
}

var col_count = 2

func initialize_option_menu(character_options: Dictionary, menu: String, columns: int = 2):
	options = character_options
	col_count = columns
	active_menu = menu
	
	draw_options()
	
	get_selected_option().set_cursor_active()
	emit_signal("active_option", options[get_selected_option().id])
	emit_signal("set_tooltip", get_action_tooltip())

# Changes which option is focused on
func move_cursor(direction_x, direction_y):
	if options.size() == 0:
		return 1
	
	get_selected_option().set_cursor_inactive()
	
	cursor_positions[active_menu] += Vector2(direction_x, direction_y)
	
	# Prevents the cursor from going out of bounds
	cursor_positions[active_menu].x = clamp(cursor_positions[active_menu].x, 0, col_count - 1)
	cursor_positions[active_menu].y = clamp(cursor_positions[active_menu].y, 0, get_options_in_column())
	
	emit_signal("active_option", options[get_selected_option().id])
	emit_signal("set_tooltip", get_action_tooltip())
	
	get_selected_option().set_cursor_active()

# Instances options and places them
func draw_options():
	var index = 0
	for option in options:
		print(option)
		var action = option_buttons.instance()
		action.id = option
		
		get_child(index % col_count).add_child(action)
		
		index += 1

func get_selected_option():
	return get_child(cursor_positions[active_menu].x).get_child(cursor_positions[active_menu].y)

func get_options_in_column():
	return get_child(cursor_positions[active_menu].x).get_child_count() - 1

func reset_cursor_positions():
	cursor_positions = {
	"item": Vector2(0,0),
	"option": Vector2(0,0),
	"skill": Vector2(0,0)
	}

func get_action_tooltip():
	return options[get_selected_option().id]["tooltip"]
