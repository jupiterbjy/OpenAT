class_name LevelList
extends HBoxContainer


@onready var _area_selector: AreaList = get_owner().get_child(0)
@onready var level_previews: Array[LevelPreview] = [
	$map_preview1,
	$map_preview2,
	$map_preview3,
	$map_preview4,
	$map_preview5,
]

var selected_id: int = UserState.current_level


func validate_selection():
	pass


## Updates preview states to match user state.
func update_preview():
	
	# unselect, disable, hide all previews
	for preview in level_previews:
		
		preview.hide()
		preview.lock()
		preview.unselect()
	
	var selected_area = _area_selector.selected_id
	var areas = MapJsonLoader.maps[selected_area - 1]
	
	# update previews
	for level_id in range(len(areas["level"])):
		
		level_previews[level_id].show()
		level_previews[level_id].load_preview(
			areas["texture"], selected_area, level_id
		)
	
	var open_level_id: int = UserState.current_level
	
	# if area_id < current_area_id then area should fully open
	if selected_area < UserState.current_area:
		open_level_id = len(areas["level"]) - 1
	
	selected_id = open_level_id
	
	# unlock maps to match user progression
	for level_id in range(0, open_level_id + 1):
		level_previews[level_id].unlock()
	
	# select last open map
	level_previews[open_level_id].select()
	
	# emit signal for selection
	UISignals.level_selected.emit(open_level_id)


## Reflects level selection to UI
func change_selection(to_id: int):
	if selected_id == to_id:
		return
	
	level_previews[selected_id].unselect()
	
	selected_id = to_id
	level_previews[to_id].select()
	
	UISignals.level_selected.emit(to_id)


func _on_map_preview_1_level_clicked():
	change_selection(0)


func _on_map_preview_2_level_clicked():
	change_selection(1)


func _on_map_preview_3_level_clicked():
	change_selection(2)


func _on_map_preview_4_level_clicked():
	change_selection(3)


func _on_map_preview_5_level_clicked():
	change_selection(4)
