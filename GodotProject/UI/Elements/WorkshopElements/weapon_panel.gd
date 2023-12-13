class_name WeaponPanel extends ScrollContainer


signal purchase_requested(type_enum, price: int, weapon_name: String)
signal select_requested(type_enum)


@onready var items: Array[Node] = $vbox.get_children()


## update all item entries
func trigger_update():
	for item in items:
		item.update_state()
