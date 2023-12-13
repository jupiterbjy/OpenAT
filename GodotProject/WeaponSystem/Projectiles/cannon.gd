extends BaseProjectile


func pre_ready_setup(upgrades: Array, is_allie: bool, fired_from: Node3D):
	_pre_ready_setup(upgrades, is_allie, fired_from)


func _on_audio_player_finished():
	if _model:
		return
	
	queue_free()
