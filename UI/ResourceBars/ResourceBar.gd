extends HBoxContainer

func update_visuals(current_mana, maximum_mana):
	$ColorRect/MarginContainer/Amount.text = str(current_mana)
	$ProgressBar.value = current_mana
	$ProgressBar.max_value = maximum_mana
