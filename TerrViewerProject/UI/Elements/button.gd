extends TextureButton


func _on_mouse_entered():
	GlobalSignals.mouse_entered.emit()


func _on_pressed():
	GlobalSignals.mouse_clicked.emit()
