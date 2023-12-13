extends Control


## main menu reference. Filled by main menu driver
var main_menu = null


func _on_no_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.MAIN_MENU)


func _on_ok_button_button_clicked():
	get_tree().quit()
