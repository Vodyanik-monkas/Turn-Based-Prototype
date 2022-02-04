extends HBoxContainer

var id = "name"
var active = false

func _ready():
	$Label.text = id

func set_cursor_active():
	active = true
	$Selected.show()

func set_cursor_inactive():
	active = false
	$Selected.hide()

func toggle_active():
	active = not active
	if active:
		$Selected.show()
	else:
		$Selected.hide()
