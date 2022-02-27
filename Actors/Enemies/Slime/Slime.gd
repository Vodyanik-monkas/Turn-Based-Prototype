extends Actor

signal aggro_updated

var boons = []
var debuffs = []

var aggro: float = 0
export(float, 0.5, 2, 0.1) var aggro_multiplier = 1

enum State {
	HEALTHY,
	INJURED,
	BLOODIED
}

var current_state = State.HEALTHY

func change_aggro(amount: float) -> void:
	aggro += amount

func take_action():
	match current_state:
		State.HEALTHY:
			use_skill($Skills.skills["pound"])
		State.INJURED:
			print("injured")
		State.BLOODIED:
			print("Bloodied")

func use_skill(skill: Dictionary):
	print(skill)
