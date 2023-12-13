extends Control


@onready var _width_label: Label = $blue_box_titled/VBoxContainer/HBoxContainer/width_label
@onready var _height_label: Label = $blue_box_titled/VBoxContainer/HBoxContainer2/height_label

signal ok_pressed

var width = 21
var height = 21

var _min_val = 10
var _max_val = 30


func _on_width_left_pressed():
	if width > _min_val:
		width -= 1
		_width_label.text = str(width)


func _on_width_right_pressed():
	if width < _max_val:
		width += 1
		_width_label.text = str(width)


func _on_height_left_pressed():
	if height > _min_val:
		height -= 1
		_height_label.text = str(height)


func _on_height_right_pressed():
	if height < _max_val:
		height += 1
		_height_label.text = str(height)


func _on_ok_button_button_clicked():
	ok_pressed.emit()
	hide()
