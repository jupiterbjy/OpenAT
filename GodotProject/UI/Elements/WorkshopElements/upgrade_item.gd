class_name WeaponItem extends HBoxContainer


var price = 100

@export var type: WorkshopSystem.UP
@export var upgrade_name: String

@onready var icon_button: TextureButton = $icon/icon_button
@onready var up_arrow: Sprite2D = $available_icon/up_arrow


## reset button state back to default
func reset_state():
	icon_button.show()
	$available_icon.show()
	$texts.show()
	$texts/state_label.show()
	$icon/icon_blocked.show()
	

## Empty out this upgrade - this is behavior when reaching max upgrade.
func set_blank():
	icon_button.hide()
	$texts.hide()
	$available_icon.hide()


## Grey out this upgrade - this is behavior when lacking money.
func set_unaffordable():
	$available_icon.hide()


## Set this open for purchase
func set_open():
	$texts/state_label.hide()
	$icon/icon_blocked.hide()


func update_icon():
	var x_offset = type
	var y_offset = UserState.upgrades[type]
	
	icon_button.texture_normal.region = Rect2(x_offset * 64, y_offset * 64, 64, 64)


## Validate User's state and adjust item state accordingly
func update_state():
	reset_state()
	update_icon()
	
	if 4 <= UserState.upgrades[type]:
		set_blank()
		return
	
	price = WorkshopSystem.upgrade_pricing[type][UserState.upgrades[type]]
	$texts/price_label.text = "Price %s" % price
	
	if price > UserState.money:
		set_unaffordable()
	else:
		set_open()


func _ready():
	$texts/name_label.text = upgrade_name
	update_state()


func _on_icon_button_pressed():
	MouseSignals.mouse_clicked.emit()
	get_parent().get_owner().purchase_requested.emit(type, price, upgrade_name)


func _on_icon_button_mouse_entered():
	MouseSignals.mouse_entered.emit()
	up_arrow.texture.region = Rect2(64, 384, 64, 64)


func _on_icon_button_mouse_exited():
	up_arrow.texture.region = Rect2(0, 384, 64, 64)
