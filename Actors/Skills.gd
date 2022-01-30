extends Node

var option_list = ["fight", "defend", "item", "switch", "run", "pass"]

var skills = {
	attack = {
		"base_damage": 1,
		"damage_type": "physical",
		"mana_cost": 3
	},
	
	stronger_attack = {
		"base_damage": 5,
		"damage_type": "physical",
		"mana_cost": 8
	}
}

func get_option_menu():
	return option_list

func get_skills():
	return skills
