extends HBoxContainer

signal set_tooltip

export(PackedScene) var option_buttons

var options: Dictionary

var active_menu: String
var cursor_positions = {
	"item": Vector2(0,0),
	"option": Vector2(0,0),
	"skill": Vector2(0,0)
}

var col_count: int
var current_mana: int

func set_option_menu(
	character_options: Dictionary, 
	menu: String,
	available_mana: int
	) -> void:
		options = character_options
		active_menu = menu
		current_mana = available_mana
		
		if menu == "option":
			col_count = 2
		else:
			col_count = 1
		
		draw_options()
		
		get_hovered_button().set_cursor_active()
		emit_signal("set_tooltip", get_action_tooltip())

# Changes which option is focused on
func move_cursor(direction_x, direction_y) -> void:
	if options.size() == 0:
		return
	
	get_hovered_button().set_cursor_inactive()
	
	cursor_positions[active_menu] += Vector2(direction_x, direction_y)
	
	# Prevents the cursor from going out of bounds
	cursor_positions[active_menu].x = clamp(cursor_positions[active_menu].x, 0, col_count - 1)
	cursor_positions[active_menu].y = clamp(cursor_positions[active_menu].y, 0, get_options_in_column())
	
	emit_signal("set_tooltip", get_action_tooltip())
	
	get_hovered_button().set_cursor_active()

# Instances options and places them
func draw_options() -> void:
	var index = 0
	for option in options:
		var action = option_buttons.instance()
		action.id = option
		
		get_child(index % col_count).add_child(action)
		
		if col_count == 1:
			$Column2.set_h_size_flags(SIZE_EXPAND+SIZE_SHRINK_END)
			
			var additional_info = option_buttons.instance()
			if current_mana < options[option]["mana_cost"]:
				var diff = options[option]["mana_cost"] - current_mana
				
				additional_info.id = str(current_mana) + "mp"
				additional_info.id += "+"+ str(diff * 2) + "hp"
				additional_info.set_colors(Color("#7aacff"), Color("#5e0000"))
			else:
				additional_info.id = str(options[option]["mana_cost"]) + "mp"
				additional_info.set_colors(Color("#7aacff"))
			
			$Column2.add_child(additional_info)
		else:
			$Column2.set_h_size_flags(SIZE_EXPAND_FILL)
		
		
		index += 1

func get_hovered_button() -> Node:
	return get_child(cursor_positions[active_menu].x).get_child(cursor_positions[active_menu].y)

func get_hovered_button_dictionary() -> Dictionary:
	return options[get_hovered_button().id]

func get_options_in_column() -> int:
	return get_child(cursor_positions[active_menu].x).get_child_count() - 1

func reset_cursor_positions() -> void:
	cursor_positions = {
	"item": Vector2(0,0),
	"option": Vector2(0,0),
	"skill": Vector2(0,0)
	}

func get_action_tooltip() -> String:
	return options[get_hovered_button().id]["tooltip"]
