extends Node

var active_character: Object

func _ready():
	set_party_positions()
	active_character = $Party.get_child(0)

func get_character_info():
	return active_character.get_skillset()

func set_new_active_character(next_character):
	active_character = $Party.next_character

func set_party_positions():
	# Setting a few usable variables
	var character_spacing_x = 150/$Party.get_child_count()
	var character_spacing_y = 200
	var base_y = 100
	var base_x = 400
	var position0_y = 200
	
	# Setting x and y position of each character in party
	for party_position in $Party.get_child_count():
		$Party.get_child(party_position).position.x = base_x - character_spacing_x * party_position
		if party_position == 0:
			$Party.get_child(party_position).position.y = position0_y
		else:
			$Party.get_child(party_position).position.y = base_y + character_spacing_y * (party_position - 1)
