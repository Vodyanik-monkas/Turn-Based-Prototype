extends Node

var option_list = {
	attack = {
		"tooltip": "A basic physical attack. MP:3"
	}, 
	defend = {
		"tooltip": "This option is brought to you by a rock."
	},
	piss = {
		"tooltip": "Only a natural response when considering getting your guts spilled across the pavement. MP: 100%"
	}
}

var skills = {
	attack = {
		"base_damage": 1,
		"damage_type": "physical",
		"mana_cost": 0,
		"tooltip": "A basic physical attack"
	},
	
	stronger_attack = {
		"base_damage": 5,
		"damage_type": "physical",
		"mana_cost": 8,
		"tooltip": "A strong physical attack"
	}
}

func get_option_menu():
	return option_list

func get_skills():
	return skills
