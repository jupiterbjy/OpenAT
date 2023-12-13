extends Control


func _on_start_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.HUD)
	CamSignals.request_cam.emit(CamManager.INGAME)
	MapSignals.game_unpause.emit()
	
	MusicManager.crossfade_to(MusicManager.MUSIC_GAME)
	CursorControl.set_battle_cursor()


func _ready():
	MapSignals.game_pause.emit()


func _on_workshop_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.WORKSHOP)
