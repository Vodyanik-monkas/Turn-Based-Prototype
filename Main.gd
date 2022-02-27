extends Node

var is_player_turn: bool = true

func _ready():
	randomize()
	for i in range(0, $Player.party_size):
		var s = $Player.get_stats(i)
		var p = $Player.get_character_portrait(i)
		
		$HUD.set_character_panel(i, s, p)

func _on_Player_health_changed(character_index: int, current_health: int, max_health: int) -> void:
	$HUD.update_character_panel("health", character_index, current_health, max_health)

func _on_Player_mana_changed(character_index: int, current_health: int, max_health: int) -> void:
	$HUD.update_character_panel("mana", character_index, current_health, max_health)

func _on_StateMachine_change_target(increment) -> void:
	var skill = $HUD.get_hovered_option()
	get_node(skill["target"]).target(skill["scope"], increment)

func _on_StateMachine_move_cursor(direction: Vector2) -> void:
	$HUD.move_cursor(direction.x, direction.y)

func _on_StateMachine_new_menu(menu: String) -> void:
	get_tree().call_group("options", "queue_free")
	yield(get_tree(), "idle_frame")
	
	if menu == "skill":
		$HUD.set_combat_dialogue_box(
			$Player.get_skillset().skills, 
			menu, 
			$Player.get_stats($Player.active_character).current_mana
		)
	if menu == "option":
		$HUD.set_combat_dialogue_box($Player.get_skillset().option_list, menu)

func _on_StateMachine_option_selected() -> void:
	var selected_option = $HUD.get_hovered_option()
	if !selected_option.empty():
		$StateMachine.change_to(selected_option["next_state"])

func _on_StateMachine_unselect_all() -> void:
	$Player.unselect()
	$Enemy.unselect()

func _on_StateMachine_use_skill(node_name: String, skill: Dictionary = $HUD.get_hovered_option()) -> void:
	var attacker = get_node(node_name)
	var attacker_stats = attacker.get_stats(attacker.active_character)
	var targeted_group = get_node(skill["target"])

	if attacker_stats.current_mana < skill["mana_cost"]:
		var diff = skill["mana_cost"] - attacker_stats.current_mana
		attacker.change_health(attacker.active_character, -diff * 2)

	attacker.run_animation(attacker.active_character, skill["animation"])
	attacker.change_mana(attacker.active_character, -skill["mana_cost"])
	
	match skill["type"]:
		"physical":
			targeted_group.take_damage(skill, attacker_stats.strength)
		"magical":
			targeted_group.take_damage(skill, attacker_stats.magic)
		"heal":
			targeted_group.heal(skill)
		"effect":
			targeted_group.apply_effect(skill)
