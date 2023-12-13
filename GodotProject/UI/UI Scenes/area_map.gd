class_name AreaList
extends Control


@onready var level_list: LevelList = $stage_selector/stage_select_list/level_list


var area_marker: PackedScene = preload("res://UI/Elements/area_marker.tscn")
var markers: Array[AreaMarker] = [null]


# current area id - level id is managed by stage_list
var selected_id: int = UserState.current_area


## loads maps.json data
func _load_maps() -> Dictionary:
	var json_content = FileAccess.open(
		"res://MapSystem/jsons/maps.json",
		FileAccess.READ
	).get_as_text()

	return JSON.parse_string(json_content)


## Listens global signal bus of area marker selection event.
## On event, disselect previous area and update variable
func _on_area_select(area_id: int):
	print("[ui_map_select] Received Signal from area %s" % area_id)
	
	# if already selected skip
	if selected_id == area_id:
		return
	
	# unselect previously selected
	markers[selected_id].set_unselected()
	markers[area_id].set_selected()
	selected_id = area_id
	
	# update preview
	level_list.update_preview()


func _on_stage_list_level_selected(level_id):
	print("[ui_map_select] Selected level %s" % level_id)
	level_list.selected_level_id = level_id


## Build markers from areas
func _build_markers():
	var maps = _load_maps()
	
	for area_idx in range(1, len(maps["areas"]) + 1):
		var area = maps["areas"][area_idx - 1]
		var marker_pos = area["marker"]
		
		var marker: AreaMarker = area_marker.instantiate()
		marker.area_id = area_idx
		
		# add to scene and update position
		markers.append(marker)
		add_child(marker)
		
		marker.position = Vector2(marker_pos[0], marker_pos[1])


## Reads player state and update selection & unlocks with previews.
## This does not care about previous unlocked state for simplicity sake
func reflect_progression():
	var progression_id: int = UserState.current_area
	
	# reset markers
	for area_id in range(1, len(markers)):
		markers[area_id].reset_default()
	
	# set cleared
	for area_id in range(1, progression_id):
		markers[area_id].set_cleared()
	
	# set selected
	markers[progression_id].set_selected()
	
	# hide locked nodes
	for area_id in range(progression_id + 1, len(markers)):
		markers[area_id].hide()
	
	# update previews
	level_list.update_preview()


func _on_arrow_left_clicked():
	
	# if selection id is 0, see if one can reduce area idx
	if 1 < selected_id:
		_on_area_select(selected_id - 1)


func _on_arrow_right_clicked():
	var areas = MapJsonLoader.maps[get_owner().get_child(0).selected_id - 1]
	
	if selected_id < UserState.current_area:
		_on_area_select(selected_id + 1)


func _ready():
	_build_markers.call_deferred()
	reflect_progression.call_deferred()
	UISignals.area_selected.connect(_on_area_select)
