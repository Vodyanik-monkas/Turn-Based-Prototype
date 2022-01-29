extends NinePatchRect

export(Texture) var portrait

func _ready():
	set_portrait(false)

func set_health(current_health, max_health):
	$MarginContainer2/HBoxContainer/ResourceBarContainers/HealthBar.value = current_health
	$MarginContainer2/HBoxContainer/ResourceBarContainers/HealthBar.max_value = max_health
	
	$MarginContainer/ResourceAmounts/Health.value = str(current_health) + "/" + str(max_health)

func set_mana(current_mana, max_mana):
	$MarginContainer2/HBoxContainer/ResourceBarContainers/ManaBar.value = current_mana
	$MarginContainer2/HBoxContainer/ResourceBarContainers/ManaBar.max_value = max_mana
	
	$MarginContainer/ResourceAmounts/Mana.value = str(current_mana) + "/" + str(max_mana)

func set_portrait(character_portrait):
	if character_portrait:
		portrait = character_portrait
	$MarginContainer2/HBoxContainer/PortraitContainer/Portrait.texture = portrait
