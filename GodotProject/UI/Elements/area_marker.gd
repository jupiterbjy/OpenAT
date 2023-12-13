class_name AreaMarker
extends Control


@onready var cleared_button = $area_cleared_button
@onready var uncleared_button = $area_uncleared_button
@onready var shine_effects = [$item_light, $item_light2, $selected_effect]

@onready var area_cleared_hover = $area_cleared_button/hover
@onready var area_cleared_normal = $area_cleared_button/normal

@onready var area_uncleared_hover = $area_uncleared_button/hover
@onready var area_uncleared_normal = $area_uncleared_button/normal

var area_id: int = 0

@export var is_cleared: bool = false
@export var is_selected: bool = false


## mark cleared and switch button
func set_cleared():
	is_cleared = true
	cleared_button.show()
	uncleared_button.hide()


## mark uncleared and switch button
func set_uncleared():
	is_cleared = false
	cleared_button.hide()
	uncleared_button.show()


## set to selected state, enabling shine effect
func set_selected():
	is_selected = true
	
	for node in shine_effects:
		node.show()


## set to unselected state, hiding shine effect
func set_unselected():
	is_selected = false
	for node in shine_effects:
		node.hide()


## Convenient method for resetting marker to default state
func reset_default():
	self.show()
	set_uncleared()
	set_unselected()


func _on_press():
	print("[AreaMarker] Area %s pressed" % area_id)
	if not is_selected:
		set_selected()
	
	UISignals.area_selected.emit(area_id)


func _ready():
	if is_cleared:
		set_cleared()
	else:
		set_uncleared()
	
	if is_selected:
		set_selected()
	else:
		set_unselected()


func _on_area_uncleared_button_mouse_entered():
	MouseSignals.mouse_entered.emit()
	area_uncleared_hover.show()
	area_uncleared_normal.hide()


func _on_area_uncleared_button_mouse_exited():
	area_uncleared_hover.hide()
	area_uncleared_normal.show()


func _on_area_cleared_button_mouse_entered():
	MouseSignals.mouse_entered.emit()
	area_cleared_hover.show()
	area_cleared_normal.hide()


func _on_area_cleared_button_mouse_exited():
	area_cleared_hover.hide()
	area_cleared_normal.show()


func _on_area_cleared_button_pressed():
	_on_press()
	MouseSignals.mouse_clicked.emit()


func _on_area_uncleared_button_pressed():
	_on_press()
	MouseSignals.mouse_clicked.emit()
