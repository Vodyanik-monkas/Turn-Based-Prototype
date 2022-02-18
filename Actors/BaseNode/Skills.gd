extends Node

var option_list = {
	fight = {
		"next_state": "OpenSkills",
		"tooltip": "Better fight than flight, I always say."
	}, 
	defend = {
		"accuracy": 100,
		"animation": "heal",
		"base_damage": 0,
		"effect": "defense_up",
		"effect_chance": 100,
		"mana_cost": 0,
		"next_state": "SelectTarget",
		"particle_fx": "none",
		"scope": "self",
		"target": "Player",
		"tooltip": "This option is brought to you by a rock.",
		"type": "effect"
	},
	piss = {
		"accuracy": 100,
		"animation": "run",
		"base_damage": 0,
		"effect": "escape",
		"effect_chance": 50,
		"mana_cost": 0,
		"next_state": "SelectTarget",
		"particle_fx": "none",
		"scope": "self",
		"target": "Player",
		"tooltip": "Only a natural response when considering getting your guts spilled across the pavement. MP: 100%",
		"type": "effect"
	}
}

var skills = {
	attack = {
		"accuracy": 95,
		"animation": "attack",
		"base_damage": 20,
		"effect": "none",
		"effect_chance": 0,
		"mana_cost": 0,
		"next_state": "SelectTarget",
		"particle_fx": "weak_physical",
		"scope": "single",
		"target": "Enemy",
		"tooltip": "A weak physical attack to one enemy.",
		"type": "physical"
	},
	
	multislash = {
		"accuracy": 90,
		"animation": "attack",
		"base_damage": 10,
		"effect": "none",
		"effect_chance": 0,
		"mana_cost": 6,
		"next_state": "SelectTarget",
		"particle_fx": "weak_physical",
		"scope": "all",
		"target": "Enemy",
		"tooltip": "A weak physical attack that hits all enemies.",
		"type": "physical"
	},
	
	first_aid = {
		"accuracy": 100,
		"animation": "heal",
		"base_damage": 6,
		"effect": "none",
		"effect_chance": 0,
		"mana_cost": 4,
		"next_state": "SelectTarget",
		"particle_fx": "heal",
		"scope": "self",
		"target": "Player",
		"tooltip": "Weak heal to self.",
		"type": "heal"
	}
}

func get_option_menu():
	return option_list

func get_skills():
	return skills
