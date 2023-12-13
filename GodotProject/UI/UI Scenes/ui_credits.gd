extends Control


func _on_ok_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.MAIN_MENU)


func _ready():
	$version.text = "Version " + UIEnum.version
