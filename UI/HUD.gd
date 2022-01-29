extends Control

signal actor_attack

func update_health_bar():
	pass

func _on_CombatDialogueBox_attack():
	emit_signal("actor_attack")


func _on_Player_set_mana(current_mana, maximum_mana):
	$MarginContainer/VBoxContainer/Status/ResourceBars/ManaBar.update_visuals(current_mana, maximum_mana)
