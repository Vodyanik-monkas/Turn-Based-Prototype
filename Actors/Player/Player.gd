extends Node

signal health_changed
signal mana_changed

var active_character: int = 0
var current_targets: Array
var current_targets_index: int = 0

var party_size: int = 1

export(Vector2) var spacing = Vector2(150, 125)
export(Vector2) var base = Vector2(325, 250)

func _on_Actor_health_changed(character_index: int, current_health: int, max_health: int):
	emit_signal("health_changed", character_index, current_health, max_health)

func _on_Actor_mana_changed(character_index: int, current_health: int, max_health: int):
	emit_signal("mana_changed", character_index, current_health, max_health)

func _ready():
	set_party_positions()

	party_size = $Party.get_child_count()

func apply_effect(skill: Dictionary) -> void:
	pass

func change_health(character: int, amount: int) -> void:
	$Party.get_child(character).change_health(amount)

func change_mana(character: int, amount: int) -> void:
	$Party.get_child(character).change_mana(amount)

func does_it_hit(accuracy: int) -> bool:
	var rando = randi() % 101
	if rando > accuracy:
		return false
	
	return true

func get_character_portrait(character_index: int) -> Texture:
	return $Party.get_child(character_index).portrait

func get_skillset() -> Node:
	return $Party.get_child(active_character).get_skillset()

func get_stats(character_index: int) -> Node:
	return $Party.get_child(character_index).get_stats()

func heal(skill: Dictionary) -> void:
	for defender in current_targets:
		if skill["effect"] != "none":
			apply_effect(skill)
		
		change_health(defender, skill["base_damage"])
		run_animation(defender, skill["animation"])
		set_and_run_fx(defender, skill["particle_fx"])

func next_character() -> void:
	active_character += 1

func run_animation(character_index: int, animation: String) -> void:
	$Party.get_child(character_index).run_animation(animation)

func set_and_run_fx(character_index: int, particle_fx: String) -> void:
	$Party.get_child(character_index).set_and_run_fx(particle_fx)

func set_party_positions() -> void:	
	for party_position in $Party.get_child_count():
		var pos = Vector2(
			-((spacing.x / $Party.get_child_count()) * party_position) + base.x, 
			(-spacing.y * sin(2 * party_position)) + base.y)
		
		$Party.get_child(party_position).position = pos

func take_damage(skill: Dictionary, attack: int) -> void:
	for defender in current_targets:
		if !does_it_hit(skill["accuracy"]):
			attack = 0
		
		var defense: int
		match skill["type"]:
			"physical":
				defense = get_stats(defender).physical_defense
			"magical":
				defense = get_stats(defender).magical_defense
		
		var unmitigated_damage = -(attack * ((100 + skill["base_damage"]) / 100.0))
		
		var mitigated_damage = unmitigated_damage * (100 / (100.0 + defense))

		var damage = int(round(mitigated_damage))
		
		if skill["effect"] != "none" and damage != 0:
			apply_effect(skill)
		
		change_health(defender, damage)
		run_animation(defender, "hurt")
		set_and_run_fx(defender, skill["particle_fx"])

func target(scope: String, index_increment: int = 0) -> void:
	current_targets.clear()
	
	if scope == "all":
		for character in $Party.get_children():
			character.cursor_active()
			current_targets.append(character.get_index())
	elif scope == "self":
		$Party.get_child(active_character).cursor_active()
		current_targets.append(active_character)
	elif scope == "single":
		$Party.get_child(current_targets_index).cursor_inactive()
		
		current_targets_index -= index_increment
		current_targets_index = clamp(current_targets_index, 0, party_size - 1)
		
		$Party.get_child(current_targets_index).cursor_active()
		current_targets.append(current_targets_index)

func unselect() -> void:
	for character in $Party.get_children():
		character.cursor_inactive()
