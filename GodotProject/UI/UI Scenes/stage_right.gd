extends TextureButton

# TODO: merge this with stage_left and use Texture2DArray


func _on_pressed():
	MouseSignals.mouse_clicked.emit()


func _on_mouse_entered():
	MouseSignals.mouse_entered.emit()
