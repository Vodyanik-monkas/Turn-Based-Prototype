extends HBoxContainer

var id = "name"

func _ready():
	$Label.text = id

func set_cursor_active():
	$Selected.show()

func set_cursor_inactive():
	$Selected.hide()
