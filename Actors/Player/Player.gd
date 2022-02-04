extends Node

var active_character: Object

func _ready():
	set_party_positions()
	active_character = $Party.get_child(0)

func get_character_info():
	return active_character.get_skillset()

func set_new_active_character(next_character):
	active_character = $Party.get_child(next_character)

# Sets physical positions of party members on game scene
func set_party_positions():
	# Setting a few usable variables
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

# Return character skillset
func get_skillset():
	return active_character.get_skillset()

func get_health_and_mana(character_index):
	return $Party.get_child(character_index).get_stats()

func get_party_size():
	return $Party.get_child_count()

func change_health(amount):
	active_character.change_health(amount)
