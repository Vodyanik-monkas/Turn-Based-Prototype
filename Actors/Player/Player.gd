extends Node

var active_character: Object

var party_size: int = 1

func _ready():
	set_party_positions()
	
	active_character = $Party.get_child(0)
	party_size = $Party.get_child_count()

func set_new_active_character(next_character) -> void:
	active_character = $Party.get_child(next_character)

# Sets physical positions of party members on game scene
func set_party_positions() -> void:
	var character_spacing_x = 150 / get_party_size()
	var character_spacing_y = 200
	var base_y = 100
	var base_x = 400
	var position0_y = 200
	
	# Setting x and y position of each character in party
	for party_position in get_party_size():
		$Party.get_child(party_position).position.x = base_x - character_spacing_x * party_position
		if party_position == 0:
			$Party.get_child(party_position).position.y = position0_y
		else:
			$Party.get_child(party_position).position.y = base_y + character_spacing_y * (party_position - 1)

func get_skillset() -> Node:
	return active_character.get_skillset()

func get_stats(character_index) -> Node:
	return $Party.get_child(character_index).get_stats()

func get_party_size() -> int:
	return $Party.get_child_count()

func get_character_portrait(character_index) -> Texture:
	return $Party.get_child(character_index).portrait

func change_health(amount) -> void:
	active_character.change_health(amount)
