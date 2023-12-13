class_name UpgradePanel extends ScrollContainer


signal purchase_requested(type_enum, price: int, upgrade_name: String)


@onready var items: Array[Node] = $vbox.get_children()


## update all item entries
func trigger_update():
	for item in items:
		item.update_state()
