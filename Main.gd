extends Node

func _ready():
	for i in range(0, $Player.party_size):
		var s = $Player.get_stats(i)
		var p = $Player.get_character_portrait(i)
		
		$HUD.set_character_panel(i, s, p)
	
	$HUD.initialize_combat_dialogue_box($Player.get_skillset().option_list)

func _on_HUD_new_turn(turn):
	$HUD.initialize_combat_dialogue_box($Player.get_skillset().option_list)

func update_combat_dialogue_box(is_skills_showing: bool):
	if is_skills_showing:
		$HUD.initialize_combat_dialogue_box($Player.get_skillset().skills)
	else:
		$HUD.initialize_combat_dialogue_box($Player.get_skillset().option_list)
