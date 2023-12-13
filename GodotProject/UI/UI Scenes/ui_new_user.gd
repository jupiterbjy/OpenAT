extends Control


@onready var _line_edit: LineEdit = $blue_box_titled/MarginContainer/type_box


func action():
	# create new user
	
	if not UserState.create_new_user(_line_edit.text):
		UISignals.request_ui.emit(UIEnum.NAME_TAKEN)
		return
	
	# let main UI know creation is done
	UserState.new_user_created.emit()
	
	UISignals.request_ui.emit(UIEnum.MAIN_MENU)


func _on_ok_button_button_clicked():
	action()


func _on_type_box_text_submitted(new_text):
	action()
