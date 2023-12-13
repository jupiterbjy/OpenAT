extends Control


@onready var areas: AreaList = $area_map
@onready var levels: LevelList = areas.level_list


var active_level = null


func _on_back_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.MAIN_MENU)


func _on_start_button_button_clicked():
	print(
		"[ui_map_select] start [a:%s l:%s]" % [
			areas.selected_id,
			levels.selected_id,
		]
	)
	
	active_level = MapJsonLoader.get_level_data(areas.selected_id, levels.selected_id)
	
	VolumeManager.unmute_ingame_sound()
	
	MapSignals.game_pause.emit()
	MapSignals.game_start.emit(areas.selected_id, levels.selected_id)
	SceneSignals.request_scene.emit(SceneManager.LEVEL)
	
	# if 1-1 show tutorial first
	if areas.selected_id == 1 and levels.selected_id == 0:
		UISignals.request_ui.emit(UIEnum.TUTORIAL)
	else:
		UISignals.request_ui.emit(UIEnum.BRIEFING)
	
	CamSignals.request_cam.emit(CamManager.INGAME_PAUSED)
