extends BaseItem


@export var heal_amount: int = 1000


func action(area: Area3D) -> bool:
	if not (area.is_in_group("allie") and area.is_in_group("tank")):
		return false
	
	# heal
	var health_bar: HealthBar = area.get_owner().health_bar
	
	health_bar.get_damage(-heal_amount)
	UISignals.player_health_ratio_changed.emit(health_bar.health / float(health_bar.health_max))
	
	return true
