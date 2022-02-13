extends Node

var option_list = {
	fight = {
		"next_state": "OpenSkills",
		"tooltip": "Better fight than flight, I always say."
	}, 
	defend = {
		"next_state": "SelectTarget",
		"scope": "self",
		"target": "Player",
		"tooltip": "This option is brought to you by a rock."
	},
	piss = {
		"next_state": "SelectTarget",
		"scope": "self",
		"target": "Player",
		"tooltip": "Only a natural response when considering getting your guts spilled across the pavement. MP: 100%"
	}
}

var skills = {
	attack = {
		"base_damage": 5,
		"damage_type": "physical",
		"mana_cost": 0,
		"next_state": "SelectTarget",
		"scope": "single",
		"target": "Enemy",
		"tooltip": "A weak physical attack to one enemy."
	},
	
	multislash = {
		"base_damage": 2,
		"damage_type": "physical",
		"mana_cost": 8,
		"next_state": "SelectTarget",
		"scope": "all",
		"target": "Enemy",
		"tooltip": "A weak physical attack that hits all enemies."
	},
	
	first_aid = {
		"base_damage": 8,
		"damage_type": "heal",
		"mana_cost": 4,
		"next_state": "SelectTarget",
		"scope": "self",
		"target": "Player",
		"tooltip": "Weak heal to self."
	}
}

func get_option_menu():
	return option_list

func get_skills():
	return skills
