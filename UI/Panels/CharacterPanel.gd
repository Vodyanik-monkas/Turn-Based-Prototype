extends NinePatchRect

func _ready():
	hide()

func set_health(current_health, max_health):
	print(current_health)
	$MarginContainer2/HBoxContainer/ResourceBarContainers/VBoxContainer/HealthBar.value = current_health
	$MarginContainer2/HBoxContainer/ResourceBarContainers/VBoxContainer/HealthBar.max_value = max_health
	
	$MarginContainer/ResourceAmounts/Health.text = str(current_health) + "/" + str(max_health)

func set_mana(current_mana, max_mana):
	$MarginContainer2/HBoxContainer/ResourceBarContainers/VBoxContainer/ManaBar.value = current_mana
	$MarginContainer2/HBoxContainer/ResourceBarContainers/VBoxContainer/ManaBar.max_value = max_mana
	
	$MarginContainer/ResourceAmounts/Mana.text = str(current_mana) + "/" + str(max_mana)

func set_portrait(character_portrait: Texture):
	$MarginContainer2/HBoxContainer/PortraitContainer/Portrait.texture = character_portrait

