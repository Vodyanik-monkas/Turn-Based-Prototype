extends NinePatchRect

signal attack

func _ready():
	$MarginContainer/HBoxContainer/PlayerOptions/CombatMenu/AttackButton.grab_focus()


func _on_AttackButton_focus_entered():
	var info = $MarginContainer/HBoxContainer/InfoBox/InfoText
	info.text = "The best Defense is a good offense.\n\n            -Emperor HiroHito"


func _on_DefendButton_focus_entered():
	var info = $MarginContainer/HBoxContainer/InfoBox/InfoText
	info.text = "A good choice if you're a rock"


func _on_RunButton_focus_entered():
	var info = $MarginContainer/HBoxContainer/InfoBox/InfoText
	info.text = "Due to a supply shortage of working RUN buttons, running away is currently unavailable.\nWe are sorry for the inconvenience."


func _on_AttackButton_pressed():
	emit_signal("attack")
