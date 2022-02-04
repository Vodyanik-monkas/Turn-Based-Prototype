extends Node

func _on_HUD_new_turn(turn):
	var character_index = turn % $Player.get_party_size()
	
	$Player.set_new_active_character(character_index)
	
	$HUD.initialize_combat_dialogue_box($Player.get_skillset().option_list)
