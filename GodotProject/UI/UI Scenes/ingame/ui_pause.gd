extends Control


# Called when the node enters the scene tree for the first time.


func _on_objective_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.OBJECTIVES)


func _on_options_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.SETTINGS, UIEnum.PAUSE)


func _on_no_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.MAIN_MENU)
	
	# level must be still loaded, run it on demo mode
	var level: Level = SceneSignals.current_scene.get_child(0)
	
	level.enable_demo_mode()
	
	MapSignals.game_unpause.emit()
	MusicManager.crossfade_to(MusicManager.MUSIC_MENU)


func _on_ok_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.HUD)
	CamSignals.request_cam.emit(CamManager.INGAME)
	MapSignals.game_unpause.emit()
	CursorControl.set_battle_cursor()


func _unhandled_input(event):
	if event.get_action_strength("open_menu"):
		MapSignals.game_unpause.emit()
		
		UISignals.request_ui.emit(UIEnum.HUD)
		CamSignals.request_cam.emit(CamManager.INGAME)
