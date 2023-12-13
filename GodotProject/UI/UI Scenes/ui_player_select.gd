extends Control


@onready var item_list: CustomItemList = $blue_box_titled/custom_item_list

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_ok_button_button_clicked():
	if item_list.selection_key:
		UserState.load_json(item_list.selection_key)
	
	UISignals.request_ui.emit(UIEnum.MAIN_MENU)


func _on_new_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.NEW_USER)


func _on_delete_button_button_clicked():
	if not item_list.selection_key:
		return
	
	UISignals.delete_candidate_key = item_list.selection_key
	UISignals.request_ui.emit(UIEnum.DELETE_USER)
