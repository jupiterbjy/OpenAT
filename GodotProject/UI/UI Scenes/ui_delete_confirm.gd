extends Control


func _ready():
	$blue_box_titled/label2.text = UserState.user_names_cache[
		str(UISignals.delete_candidate_key)
	]


func _on_no_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.SELECT_USER)


func _on_ok_button_button_clicked():
	UserState.delete_user(UISignals.delete_candidate_key)
	UISignals.request_ui.emit(UIEnum.SELECT_USER)
