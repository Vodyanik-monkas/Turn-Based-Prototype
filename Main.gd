extends Node

var is_player_turn: bool = true

func _ready():
	for i in range(0, $Player.party_size):
		var s = $Player.get_stats(i)
		var p = $Player.get_character_portrait(i)
		
		$HUD.set_character_panel(i, s, p)

func calculate_damage(skill: Dictionary, attacker_stats: Node, defender_stats: Node) -> int:
	var attacking_stat: int
	var defending_stat: int
	
	if skill["type"] == "physical":
		attacking_stat = attacker_stats.strength
		defending_stat = defender_stats.physical_defense
	if skill["type"] == "magical":
		attacking_stat = attacker_stats.magic
		defending_stat = defender_stats.magical_defense
	if skill["type"] == "heal":
		return skill["base_damage"]
	
	var unmitigated_damage = -(
		attacker_stats.strength * ((100 + skill["base_damage"]) / 100.0))
	
	var mitigated_damage = unmitigated_damage * (100 / (100.0 + defending_stat))

	return int(round(mitigated_damage))

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
	
	if is_player_turn:
		attacker_stats = $Player.get_stats($Player.active_character)
		$Player.change_mana($Player.active_character, -skill["mana_cost"])
	else:
		attacker_stats = $Enemy.get_stats(0)
	
	var targeted_group = get_node(skill["target"])
	defenders = targeted_group.current_targets
	for defender in defenders:
		var d = calculate_damage(skill, attacker_stats, targeted_group.get_stats(defender))
		targeted_group.change_health(defender, d)


func _on_Player_health_changed(character_index: int, current_health: int, max_health: int) -> void:
	$HUD.update_character_panel("health", character_index, current_health, max_health)


func _on_Player_mana_changed(character_index: int, current_health: int, max_health: int) -> void:
	$HUD.update_character_panel("mana", character_index, current_health, max_health)
