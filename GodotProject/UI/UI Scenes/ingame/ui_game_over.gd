extends Control


func _on_ok_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.MAP_SELECT)
	SceneSignals.request_scene.emit(SceneManager.LEVEL)
	CamSignals.request_cam.emit(CamManager.FOLLOW)
	MapSignals.enter_demo.emit()
