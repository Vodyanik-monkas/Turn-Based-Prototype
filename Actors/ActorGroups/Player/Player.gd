extends ActorGroup

signal health_changed
signal mana_changed

func _on_Actor_health_changed(character_index: int, current_health: int, max_health: int):
	emit_signal("health_changed", character_index, current_health, max_health)

func _on_Actor_mana_changed(character_index: int, current_health: int, max_health: int):
	emit_signal("mana_changed", character_index, current_health, max_health)

func _ready():
	set_party_positions(-1)
