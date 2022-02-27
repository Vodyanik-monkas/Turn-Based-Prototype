extends AnimatedSprite

class_name Actor

signal dead
signal mana_changed
signal health_changed

export(Texture) var portrait

func _on_Actor_animation_finished():
	animation = "idle"

func _ready():
	playing = true

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

func run_animation(animation_name: String) -> void:
	if animation_name == "hurt":
		playing = false
		modulate = "#40ffffff"
		yield(get_tree().create_timer(.15), "timeout")
		modulate = "#70ffffff"
		yield(get_tree().create_timer(.1), "timeout")
		modulate = "#ffffffff"
		yield(get_tree().create_timer(.1), "timeout")
		playing = true
	else:
		animation = animation_name

func set_and_run_fx(particle_fx: String) -> void:
	$Particles2D.set_and_run_fx(particle_fx)
