extends HBoxContainer

var id = "name"

func _ready() -> void:
	$Label.text = id.capitalize()

func set_colors(font_color: Color, font_outline: Color = Color("#000000")) -> void:
	$Label.set("custom_colors/font_color", font_color)
	$Label.set("custom_colors/font_outline_modulate", font_outline)

func set_cursor_active() -> void:
	$Selected.show()

func set_cursor_inactive() -> void:
	$Selected.hide()
