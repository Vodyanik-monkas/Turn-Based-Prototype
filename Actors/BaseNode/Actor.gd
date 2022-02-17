extends AnimatedSprite

signal dead
signal mana_changed
signal health_changed

export(Texture) var portrait

func _on_Actor_animation_finished():
	animation = "idle"

func _ready():
	playing = true

func actor_attack():
	animation = "Attack1"

func actor_defend():
	animation = "Attack2"

func change_health(health):
	$Stats.current_health += health
	$Stats.current_health = clamp($Stats.current_health, 0, $Stats.max_health)
	if $Stats.current_health <= 0:
		emit_signal("dead")
	
	emit_signal("health_changed", self.get_index(), $Stats.current_health, $Stats.max_health)

func change_mana(mana):
	$Stats.current_mana += mana
	$Stats.current_mana = clamp($Stats.current_mana, 0, $Stats.max_mana)
	
	emit_signal("mana_changed", self.get_index(), $Stats.current_mana, $Stats.max_mana)

func cursor_active():
	$Cursor.playing = true
	$Cursor.show()

func cursor_inactive():
	$Cursor.playing = false
	$Cursor.hide()

func get_skillset() -> Node:
	return $Skills

func get_stats() -> Node:
	return $Stats
