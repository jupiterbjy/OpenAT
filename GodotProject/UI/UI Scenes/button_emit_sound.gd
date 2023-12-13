extends Control


func _on_mouse_entered():
	MouseSignals.mouse_entered.emit()


func _on_pressed():
	MouseSignals.mouse_clicked.emit()
