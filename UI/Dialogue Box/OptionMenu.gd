extends HBoxContainer

export(PackedScene) var option_buttons

var options = ["Attack","Defend", "Run", "Piss", "Devestate", "Cry", "NULL"]

# Starting cursor position in Options list
export var cursor_position_x = 0
export var cursor_position_y = 0

var col_count = 2

func _ready():
	# Populates instances from option list
	# and sets an active option
	draw_options()
	get_option().active()

func _unhandled_input(_event):
	
	# Moves the cursor to highlight selected option
	if Input.is_action_just_pressed("ui_up"):
		move_cursor(0, -1)
	if Input.is_action_just_pressed("ui_down"):
		move_cursor(0, 1)
	if Input.is_action_just_pressed("ui_left"):
		move_cursor(-1, 0)
	if Input.is_action_just_pressed("ui_right"):
		move_cursor(1, 0)
	
	# Communicate about selected option
	if Input.is_action_just_pressed("ui_accept"):
		select_option()


# Changes which option is focused on
func move_cursor(direction_x, direction_y):
	get_option().inactive()
	
	cursor_position_x += direction_x
	cursor_position_y += direction_y

	cursor_position_x = clamp(cursor_position_x, 0, col_count - 1)
	cursor_position_y = clamp(cursor_position_y, 0, get_options_in_column())

	get_option().active()

# Instances options and places them
func draw_options():
	for option in range(0, options.size()):
		var action = option_buttons.instance()
		action.namaewa = options[option]
		
		if option % col_count == 0:
			$Column1.add_child(action)
		else:
			$Column2.add_child(action)

# Gets option cursor is currently on
func get_option():
	var option = get_child(cursor_position_x).get_child(cursor_position_y)
	return option

# Returns the number of rows in current cursors column
func get_options_in_column():
	return get_child(cursor_position_x).get_child_count() - 1

func select_option():
	pass
