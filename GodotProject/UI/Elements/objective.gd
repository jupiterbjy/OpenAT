
extends MarginContainer


static var _descriptions = [
	"Pick up all boxes",
	"Destroy all bunkers",
	"Destroy all enemies",
	"Defend your base",
]


func set_type(type_enum):
	var obj_icon: ObjectiveIcon = $HBoxContainer/objective_icon
	var desc: Label = $HBoxContainer/MarginContainer/description
	
	desc.text = _descriptions[type_enum]
	obj_icon.set_type(type_enum)
