extends Node

export(Vector2) var spacing = Vector2(250, 150)
export(Vector2) var base = Vector2(700, 250)

var active_character: Object
var current_targets: Array
var current_targets_index: int = 0

func _ready():
	set_party_positions()

func change_health(character: int, amount: int) -> void:
	$Party.get_child(character).change_health(amount)

func get_stats(character_index: int) -> Node:
	return $Party.get_child(character_index).get_stats()

func set_party_positions() -> void:	
	for party_position in $Party.get_child_count():
		var pos = Vector2(
			((spacing.x / $Party.get_child_count()) * party_position) + base.x, 
			(-spacing.y * sin(2 * party_position)) + base.y)
		
		$Party.get_child(party_position).position = pos

func target(scope: String, index_increment: int = 0) -> void:
	current_targets.clear()
	
	if scope == "all":
		for character in $Party.get_children():
			character.cursor_active()
			current_targets.append(character.get_index())
	elif scope == "single":
		$Party.get_child(current_targets_index).cursor_inactive()
		
		current_targets_index += index_increment

		current_targets_index = clamp(current_targets_index, 0, $Party.get_child_count() - 1)

		$Party.get_child(current_targets_index).cursor_active()
		current_targets.append($Party.get_child(current_targets_index).get_index())

func unselect() -> void:
	for character in $Party.get_children():
		character.cursor_inactive()
