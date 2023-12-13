class_name UpgradeItem extends HBoxContainer


@export var type: WorkshopSystem.WEAPON
@export var weapon_name: String
@export var price: int

@onready var icon_button: TextureButton = $icon/icon_button
@onready var up_arrow: Sprite2D = $available_icon/up_arrow


var purchased = false


## reset button state back to default, aka all show mode to reduce chances of error
func reset_state():
	$available_icon.show()
	$purchased_icon.show()
	$icon/icon_blocked.show()
	
	$selected_bg.show()
	
	$texts/price_label.show()
	$texts/state_label.show()


## Grey out this upgrade - this is behavior when lacking money.
func set_unaffordable():
	$available_icon.hide()
	$purchased_icon.hide()


## Set this open for purchase
func set_open():
	$purchased_icon.hide()
	$icon/icon_blocked.hide()
	$texts/state_label.hide()


func set_owned():
	$icon/icon_blocked.hide()
	$available_icon.hide()
	$texts/state_label.hide()
	$texts/price_label.hide()


func set_selection():
	$selected_bg.visible = type == UserState.selected_weapon_idx


func update_icon():
	icon_button.texture_normal.region = Rect2(type * 64, 320, 64, 64)


## Validate User's state and adjust item state accordingly
func update_state():
	reset_state()
	set_selection()
	
	if UserState.weapons[type]:
		purchased = true
		set_owned()
		return
	
	if price > UserState.money:
		set_unaffordable()
	else:
		set_open()


func _ready():
	$texts/price_label.text = "Price %s" % price
	$texts/name_label.text = weapon_name
	
	update_icon()
	update_state()


func _on_icon_button_pressed():
	MouseSignals.mouse_clicked.emit()
	
	if purchased:
		get_parent().get_owner().select_requested.emit(type)
	else:
		get_parent().get_owner().purchase_requested.emit(type, price, weapon_name)


func _on_icon_button_mouse_entered():
	MouseSignals.mouse_entered.emit()
	up_arrow.texture.region = Rect2(64, 384, 64, 64)


func _on_icon_button_mouse_exited():
	up_arrow.texture.region = Rect2(0, 384, 64, 64)
