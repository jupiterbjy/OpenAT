extends BaseItem


func action(area: Area3D):
	if not (area.is_in_group("allie") and area.is_in_group("tank")):
		return false

	var item_subsystem: ItemSubsystem = area.get_owner().item_subsystem
	item_subsystem.set_invincible()
	return true
