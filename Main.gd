extends Node

var is_player_turn: bool = true

func _ready():
	randomize()
	for i in range(0, $Player.party_size):
		var s = $Player.get_stats(i)
		var p = $Player.get_character_portrait(i)
		
		$HUD.set_character_panel(i, s, p)

func _on_HUD_new_turn(turn: int) -> void:
	$HUD.set_combat_dialogue_box($Player.get_skillset().option_list)

func _on_HUD_new_menu(menu: String) -> void:
	get_tree().call_group("options", "queue_free")
	yield(get_tree(), "idle_frame")
	
	if menu == "skill":
		$HUD.set_combat_dialogue_box($Player.get_skillset().skills, menu, 1)
	if menu == "option":
		$HUD.set_combat_dialogue_box($Player.get_skillset().option_list, menu)

func _on_HUD_target_select(target: String, scope: String, increment: int) -> void:
	get_node(target).target(scope, increment)

func _on_HUD_unselect_all() -> void:
	$Player.unselect()
	$Enemy.unselect()

func _on_HUD_use_skill(skill: Dictionary) -> void:
	var attacker_stats
	var defenders
	var targeted_group = get_node(skill["target"])
	
	if is_player_turn:
		attacker_stats = $Player.get_stats($Player.active_character)
		$Player.run_animation($Player.active_character, skill["animation"])
		$Player.change_mana($Player.active_character, -skill["mana_cost"])
	else:
		attacker_stats = $Enemy.get_stats(0)
	
	defenders = targeted_group.current_targets
	for defender in defenders:
		match skill["type"]:
			"physical":
				var d = calculate_damage(
					skill, 
					attacker_stats.strength, 
					targeted_group.get_stats(defender).physical_defense)
				
				targeted_group.change_health(defender, d)
				targeted_group.run_animation(defender, "hurt")
			"magical":
				var d = calculate_damage(
					skill, 
					attacker_stats.magic, 
					targeted_group.get_stats(defender).magical_defense)
				
				targeted_group.change_health(defender, d)
				targeted_group.run_animation(defender, "hurt")
			"heal":
				targeted_group.change_health(defender, skill["base_damage"])
				targeted_group.run_animation(defender, skill["animation"])
			"effect":
				print("effecting")
		
		if skill["effect"] != "none":
			if does_it_hit(skill["effect_chance"]):
				targeted_group.apply_effect(skill["effect"])
		
		targeted_group.set_and_run_fx(defender, skill["particle_fx"])

func _on_Player_health_changed(character_index: int, current_health: int, max_health: int) -> void:
	$HUD.update_character_panel("health", character_index, current_health, max_health)

func _on_Player_mana_changed(character_index: int, current_health: int, max_health: int) -> void:
	$HUD.update_character_panel("mana", character_index, current_health, max_health)

func calculate_damage(skill: Dictionary, attacking_stat: int, defending_stat: int) -> int:
	if does_it_hit(skill["accuracy"]):
		return 0
	
	var unmitigated_damage = -(
		attacking_stat * ((100 + skill["base_damage"]) / 100.0))
	
	var mitigated_damage = unmitigated_damage * (100 / (100.0 + defending_stat))

	return int(round(mitigated_damage))

func does_it_hit(accuracy: int) -> bool:
	var rando = randi() % 101
	if rando < accuracy:
		return true
	
	return false
