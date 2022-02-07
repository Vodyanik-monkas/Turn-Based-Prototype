extends Node

func _ready():
	for i in range(0, $Player.party_size):
		var s = $Player.get_stats(i)
		$HUD.set_character_panel(i, s, $Player.get_character_portrait(i))

func _on_HUD_new_turn(turn):
	var character_index = turn % $Player.get_party_size()
	
	$Player.set_new_active_character(character_index)
	
	$HUD.initialize_combat_dialogue_box($Player.get_skillset().option_list)

func update_combat_dialogue_box(is_skills_showing: bool):
	if is_skills_showing:
		$HUD.initialize_combat_dialogue_box($Player.get_skillset().skills)
	else:
		$HUD.initialize_combat_dialogue_box($Player.get_skillset().option_list)
