extends HBoxContainer

var id = "name"

func _ready() -> void:
	$Label.text = id.capitalize()

func set_color(color: Color) -> void:
	$Label.set("custom_colors/font_color", color)

func set_cursor_active() -> void:
	$Selected.show()

func set_cursor_inactive() -> void:
	$Selected.hide()
