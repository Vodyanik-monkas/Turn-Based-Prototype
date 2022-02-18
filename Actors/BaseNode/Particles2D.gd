extends Particles2D

enum Presets {
	HEAL,
	WEAK_PHYSICAL,
	WEAK_MAGICAL
	}

export (Presets) var fx

func play_fx() -> void:
	match fx:
		Presets.HEAL:
			heal()
		Presets.WEAK_PHYSICAL:
			weak_physical()
		Presets.WEAK_MAGICAL:
			weak_magical()

func set_and_run_fx(particle_fx: String) -> void:
	for preset in Presets.keys():
		if preset == particle_fx.to_upper():
			fx = Presets[preset]
			break
	
	play_fx()

# These are functions that set properties of the Particles2D to create 
# Specific effects
func heal() -> void:
	texture = $Particles.sparkle
	
	process_material.direction = Vector3(0, 1, 0)
	process_material.spread = 45
	process_material.gravity = Vector3(0, 10, 0)
	process_material.initial_velocity = 80
	process_material.angular_velocity = 40
	process_material.angular_velocity_random = 1
	process_material.scale = 0.5
	process_material.scale_random = 1
	process_material.color = "#7eee88"
	emitting = true
	
	yield(get_tree().create_timer(1.5), "timeout")
	
	emitting = false

func weak_physical() -> void:
	texture = $Particles.sparkle
	position.y = 0
	
	explosiveness = 1
	
	process_material.set_emission_shape(process_material.EMISSION_SHAPE_SPHERE)
	process_material.direction = Vector3(0, 0, 0)
	process_material.spread = 180
	process_material.gravity = Vector3(0, 0, 0)
	process_material.initial_velocity = 200
	process_material.angular_velocity = 200
	process_material.angular_velocity_random = 1
	process_material.orbit_velocity = 1
	process_material.scale = 2
	process_material.scale_random = 1
	process_material.color = "#ef8080"
	process_material.hue_variation = 0.08
	process_material.hue_variation_random = 1
	emitting = true
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	emitting = false

func weak_magical() -> void:
	print("Insert Weak Magical particle here")
