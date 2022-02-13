extends AnimatedSprite

signal set_mana
signal set_health

export(Texture) var portrait

var party_position: int

func _ready():
	playing = true
	emit_signal("set_mana", $Stats.current_mana, $Stats.max_mana)
	emit_signal("set_health", $Stats.current_health, $Stats.max_health)

func actor_attack():
	animation = "Attack1"

func actor_defend():
	animation = "Attack2"

func change_mana(mana):
	$Stats.current_mana += mana
	$Stats.current_mana = clamp($Stats.current_mana, 0, $Stats.maximum_mana)
	
	emit_signal("set_mana", $Stats.current_mana, $Stats.maximum_mana)

func change_health(health):
	$Stats.current_health += health
	$Stats.current_health = clamp($Stats.current_health, 0, $Stats.maximum_health)
	
	emit_signal("set_health", $Stats.current_health, $Stats.maximum_health)

func get_skillset() -> Node:
	return $Skills

func get_stats() -> Node:
	return $Stats

func _on_Actor_animation_finished():
	animation = "idle"

func _on_HUD_actor_attack():
	actor_attack()
	change_mana(-3)

func cursor_active():
	$Cursor.playing = true
	$Cursor.show()

func cursor_inactive():
	$Cursor.playing = false
	$Cursor.hide()
