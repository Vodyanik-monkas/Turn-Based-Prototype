extends ActorGroup

func _ready():
	set_party_positions(1)
	set_active_character_to_character_with_most_aggro()

func change_aggro(character: int, amount: float) -> void:
	$Party.get_child(character).change_aggro(amount)

func set_active_character_to_character_with_most_aggro() -> void:
	for child in $Party.get_children():
		if child.aggro > $Party.get_child(active_character).aggro:
			active_character = child.get_index()

func start_turn() -> Dictionary:
	set_active_character_to_character_with_most_aggro()
	var skill: Dictionary = $Party.get_child(active_character).use_what_skill()
	return skill
