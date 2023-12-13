extends Control


@onready var main_menu_box = $main_menu_box
@onready var sub_viewport: SubViewport = $logo/scale_root/viewport_container/SubViewport
@onready var sub_viewport_init_size = sub_viewport.size

@onready var sub_viewport_xy_ratio: float = sub_viewport.size.x / float(sub_viewport.size.y)
@onready var baseline_ratio: float = sub_viewport.size.y / float(768)


func _on_play_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.MAP_SELECT, null, true)


func _on_option_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.SETTINGS)


func _on_stage_editor_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.HIGHSCORE)


func _on_credits_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.CREDITS)


func _on_exit_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.QUIT)


func _on_resize():
	var new_height = get_viewport().size.y * baseline_ratio
	var new_size = Vector2(
		int(new_height * sub_viewport_xy_ratio),
		int(new_height)
	)
	
	sub_viewport.size = new_size
	
	print("[ui_main_menu] Resize viewport to %s" % get_viewport().size)
	print("[ui_main_menu] Resize subviewport to %s" % new_size)
	print("[ui_main_menu] Subviewport size is now %s" % sub_viewport.size)


func _ready():
	$version.text = "Version " + UIEnum.version
	# get_viewport().size_changed.connect(_on_resize)
	# _on_resize()
