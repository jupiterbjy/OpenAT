extends ItemSubsystem


func add_star():
	if _stars < 3:
		_stars += 1
		if get_parent()._player_idx == 1:
			UISignals.player_got_star.emit()
	
	_on_star_heal_timer_timeout()
	$star_heal_timer.start(10)


func _on_star_heal_timer_timeout():
	get_parent().health_bar.get_damage(-_stars * _star_heal_amount)
