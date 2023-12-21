extends Control


func action():
	MapSignals.game_pause.emit()
	
	UISignals.request_ui.emit(UIEnum.PAUSE)
	CamSignals.request_cam.emit(CamManager.INGAME_PAUSED)


func _unhandled_input(event):
	if event.get_action_strength("open_menu"):
		action()


func _notification(what):
	# take android back button input here
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		action()
