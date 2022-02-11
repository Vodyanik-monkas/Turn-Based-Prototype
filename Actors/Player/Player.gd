extends Node

var active_character: Object

var party_size: int = 1

export(Vector2) var spacing = Vector2(150, 125)
export(Vector2) var base = Vector2(325, 250)

func _ready():
	set_party_positions()
	
	active_character = $Party.get_child(0)
	print("ready Function")
	print(active_character)
	party_size = $Party.get_child_count()

func next_character() -> void:
	active_character = $Party.get_child(active_character.party_position + 1)

func set_party_positions() -> void:	
	for party_position in $Party.get_child_count():
		var pos = Vector2(
			-((spacing.x / $Party.get_child_count()) * party_position) + base.x, 
			(-spacing.y * sin(2 * party_position)) + base.y)
		
		$Party.get_child(party_position).position = pos

func get_skillset() -> Node:
	return active_character.get_skillset()

func get_stats(character_index) -> Node:
	return $Party.get_child(character_index).get_stats()

func get_character_portrait(character_index) -> Texture:
	return $Party.get_child(character_index).portrait

func change_health(amount) -> void:
	active_character.change_health(amount)
