extends Actor

signal aggro_updated

var boons = []
var debuffs = []

export(float) var aggro = 0
export(float, 0.5, 2, 0.1) var aggro_multiplier = 1

enum State {
	HEALTHY,
	INJURED,
	BLOODIED
}

var current_state = State.HEALTHY

func change_aggro(amount: float) -> void:
	aggro += amount

func use_what_skill() -> Dictionary:
	match current_state:
		State.HEALTHY:
			return $Skills.skills["pound"]
		State.INJURED:
			print("injured")
			return {}
		State.BLOODIED:
			print("Bloodied")
			return {}
		_:
			return {}
