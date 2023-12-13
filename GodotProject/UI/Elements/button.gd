extends TextureButton


signal clicked


@onready var _normal: Sprite2D = $normal
@onready var _hover: Sprite2D = $hover


func _on_mouse_entered():
	MouseSignals.mouse_entered.emit()
	_hover.show()
	_normal.hide()


func _on_pressed():
	MouseSignals.mouse_clicked.emit()
	clicked.emit()


func _on_mouse_exited():
	_normal.show()
	_hover.hide()
