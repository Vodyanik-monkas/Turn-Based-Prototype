extends Node

var options_menu = ["fight", "defend", "item", "switch", "run", "pass"]

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
