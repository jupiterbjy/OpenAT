extends Control


func _unhandled_input(event):
	if event.get_action_strength("open_menu"):
		MapSignals.game_pause.emit()
		
		UISignals.request_ui.emit(UIEnum.PAUSE)
		CamSignals.request_cam.emit(CamManager.INGAME_PAUSED)
