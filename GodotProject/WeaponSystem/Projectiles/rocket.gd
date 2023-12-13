extends BaseProjectile


@onready var secondary_area: Area3D = $secondary_collision


func play_hit_sound(area: Area3D):
	_audio_player.stream = load("res://SoundSystem/Sounds/Dest-R.wav")
	_audio_player.play()


func pre_ready_setup(upgrades: Array, is_allie: bool, fired_from: Node3D):
	_pre_ready_setup(upgrades, is_allie, fired_from)


func _on_area_entered(area: Area3D):
	
	# skip owner's area, other tanks in same cordinate's area, and already disabled bullet.
	if not is_hit(area):
		return
	
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	
	_velocity = 0
	
	_model.queue_free()
	
	var groups = area.get_groups()
	
	if area.is_in_group(counter_group):
		damage_counter_group(area.get_parent())
	
	# TODO: Allow rocket to destroy walls - this will require rewriting wall damage calculations
	elif area.is_in_group("wall"):
		damage_wall(area.get_parent())
	
	secondary_area.monitoring = true
	post_hit_action(area)
	$disable_timer.start(0.1)
	
	var trail_pos = Vector2(area.position.x, area.position.z)
	MapSignals.spawn_trail.emit(trail_pos, Trail.ACTION.EXPLODED, randi_range(0, 3))


func _on_secondary_collision_area_entered(area):
	if area.is_in_group(counter_group):
		damage_counter_group(area.get_parent())


func _on_disable_timer_timeout():
	secondary_area.monitoring = false
