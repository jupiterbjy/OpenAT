# Need to have white selection border clickable
# but should not enlarge with that selection
# but also should not make sound when moving between selection border & prev button
# hence such complex mess you see here

class_name LevelPreview
extends TextureButton


signal level_clicked


@onready var _scale_anchor: Control = $scale_anchor_god_why_godot
@onready var _preview_button: TextureButton = $preview_button
@onready var _preview_img: LevelPreviewRect = $scale_anchor_god_why_godot/preview_image
@onready var _selection_bg: Sprite2D = $selection_bg

var selected: bool = false
var unlocked: bool = false

var _enlarge_scale: float = 1.0
var _enlarging: bool = false


func load_preview(texture_name: String, area_id: int, map_id: int):
	_preview_img.load_preview(texture_name, area_id, map_id)


func select():
	selected = true
	_selection_bg.show()
	self.disabled = false
	self.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND


func unselect():
	selected = false
	_selection_bg.hide()
	self.disabled = true
	self.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW


func unlock():
	unlocked = true
	$preview_button/locked_image.hide()
	_preview_button.disabled = false
	_preview_button.mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND


func lock():
	unlocked = false
	$preview_button/locked_image.show()
	_preview_button.disabled = true
	_preview_button.mouse_default_cursor_shape = CursorShape.CURSOR_ARROW


# having default state set in ready makes testing easier
func _ready():
	if unlocked:
		unlock()
		
		if selected:
			select()
		else:
			unselect()
	else:
		unselect()
		lock()


# initially used AnimationPlayer but it couldn't deal rapid in-out actions
# so we're going down this bad way
func _process(delta):
	if _enlarging:
		if _enlarge_scale < 1.1:
			_enlarge_scale += delta
		else:
			_enlarge_scale = 1.1
	else:
		if _enlarge_scale > 1.0:
			_enlarge_scale -= delta
		else:
			_enlarge_scale = 1.0
	
	_scale_anchor.scale = Vector2(_enlarge_scale, _enlarge_scale)


func _on_preview_button_mouse_entered():
	if unlocked:
		_enlarging = true
		MouseSignals.mouse_entered.emit()


func _on_preview_button_mouse_exited():
	_enlarging = false
	

func _on_preview_button_pressed():
	MouseSignals.mouse_clicked.emit()
	if not selected:
		select()
	
	level_clicked.emit()
