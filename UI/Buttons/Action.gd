extends HBoxContainer

var id = "name"

func _ready():
	$Label.text = id.capitalize()

func set_cursor_active():
	$Selected.show()

func set_cursor_inactive():
	$Selected.hide()
