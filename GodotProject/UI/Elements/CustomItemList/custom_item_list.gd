class_name CustomItemList
extends NinePatchRect


@onready var container: VBoxContainer = $VFlowContainer/container

var _entries: Dictionary = {}

var _custom_item_scene: PackedScene = preload("res://UI/Elements/CustomItemList/custom_item.tscn")

var selection_key = 0


func fetch_names():
	for key in UserState.user_names_cache:
		var new_item: CustomItem = _custom_item_scene.instantiate()
		
		new_item.idx = key
		
		# if same create time, then lock it. It's current user
		if str(UserState.created) == key:
			new_item.set_locked()
		
		_entries[str(key)] = new_item
		container.add_child(new_item)
		new_item.set_text(UserState.user_names_cache[key])


func on_select(key: int):
	if key == selection_key:
		_entries[str(selection_key)].set_selected()
		return
	
	# unselect prev
	
	if selection_key:
		_entries[str(selection_key)].set_unselected()
	
	selection_key = key


# Called when the node enters the scene tree for the first time.
func _ready():
	fetch_names()
	UISignals.user_selected.connect(on_select)
