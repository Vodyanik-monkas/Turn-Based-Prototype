extends Node

export(Vector2) var spacing = Vector2(250, 150)
export(Vector2) var base = Vector2(700, 250)

var current_target: Array
var current_target_index: int = 0

func _ready():
	set_party_positions()

func set_party_positions() -> void:	
	for party_position in $Party.get_child_count():
		var pos = Vector2(
			((spacing.x / $Party.get_child_count()) * party_position) + base.x, 
			(-spacing.y * sin(2 * party_position)) + base.y)
		
		$Party.get_child(party_position).position = pos

func target(scope: String, index_increment: int = 0) -> void:
	current_target.clear()
	
	if scope == "all":
		for character in $Party.get_children():
			character.cursor_active()
			current_target.append(character.get_name())
	else:
		$Party.get_child(current_target_index).cursor_inactive()
		
		current_target_index += index_increment

		current_target_index = clamp(current_target_index, 0, $Party.get_child_count() - 1)

		$Party.get_child(current_target_index).cursor_active()
		current_target.append($Party.get_child(current_target_index).get_name())

func unselect():
	for character in $Party.get_children():
		character.cursor_inactive()
