extends Control


@onready var vbox: VBoxContainer = $blue_box_titled/white_box/ScrollContainer/vbox

var format: String = ""
var scene: PackedScene = preload("res://UI/Elements/highscore_entry.tscn")


func _on_ok_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.MAIN_MENU)


func _update_entries():
	for child in vbox.get_children():
		child.queue_free()
	
	for entry_arr in GlobalState.leaderboards:
		var item = scene.instantiate()
		
		item.player_name = entry_arr[0]
		item.score = entry_arr[1]
		
		vbox.add_child(item)


func _ready():
	_update_entries()


func _on_text_button_pressed():
	GlobalState.leaderboards = []
	_update_entries()
	GlobalState.save_json()
