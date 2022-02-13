extends Node

func _ready():
	for i in range(0, $Player.party_size):
		var s = $Player.get_stats(i)
		var p = $Player.get_character_portrait(i)
		
		$HUD.set_character_panel(i, s, p)

func _on_HUD_new_turn(turn):
	$HUD.initialize_combat_dialogue_box($Player.get_skillset().option_list)

func _on_HUD_new_menu(menu: String):
	get_tree().call_group("options", "queue_free")
	yield(get_tree(), "idle_frame")
	
	if menu == "skill":
		$HUD.initialize_combat_dialogue_box($Player.get_skillset().skills, menu, 1)
	if menu == "option":
		$HUD.initialize_combat_dialogue_box($Player.get_skillset().option_list, menu)

func _on_HUD_target_select(target, scope, increment):
	get_node(target).target(scope, increment)


func _on_HUD_unselect_all():
	$Player.unselect()
	$Enemy.unselect()
