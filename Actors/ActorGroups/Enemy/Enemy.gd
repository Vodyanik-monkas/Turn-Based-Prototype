extends ActorGroup

func _ready():
	set_party_positions(1)

func change_aggro(character: int, amount: float) -> void:
	$Party.get_child(character).change_aggro(amount)
	update_active_character()

func update_active_character():
	for child in $Party.get_children():
		if child.aggro > $Party.get_child(active_character).aggro:
			active_character = child.get_index()
