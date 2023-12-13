class_name LevelInfo
extends Label


var _template: String = "episode %s, map %s ( reward %s coins )"
@onready var _area_selecter: AreaList = get_owner().get_child(0)


func update_info(area_id: int, level_id: int):
	# load level and get cost
	var level = MapJsonLoader.get_level_data(area_id, level_id)
	text = _template % [area_id, level_id + 1, level["cost"]]


# update level and info
func _on_level_selected(level_id):
	update_info(_area_selecter.selected_id, level_id)


func _ready():
	UISignals.level_selected.connect(_on_level_selected)
