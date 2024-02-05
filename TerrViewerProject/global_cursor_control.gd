extends Node

@export var default_cursor: Texture2D
@export var default_hotspot: Vector2

@export var hover_cursor: Texture2D
@export var hover_hotspot: Vector2

@export var cursor_hover_sound: AudioStream
@export var cursor_click_sound: AudioStream

@onready var _cursors: Array[Texture2D] = [default_cursor, hover_cursor]
@onready var _hotspots: Array[Vector2] = [default_hotspot, hover_hotspot]
var _types: Array[int] = [Input.CURSOR_ARROW, Input.CURSOR_POINTING_HAND]

enum {DEFAULT, HOVER, AIM}


@onready var _mouse_hover_player: AudioStreamPlayer = $mouse_hover_sound
@onready var _mouse_click_player: AudioStreamPlayer = $mouse_click_sound


func set_cursor(idx: int):
	print("[GlobalCursorControl] Installing custom cursor for %s" % idx)
	Input.set_custom_mouse_cursor(_cursors[idx], _types[idx], _hotspots[idx])


func _on_hover_signal():
	_mouse_hover_player.play()


func _on_click_signal():
	_mouse_click_player.play()


## setup cursors for hover
func _ready():
	for idx in range(len(_cursors)):
		set_cursor(idx)
	
	GlobalSignals.mouse_entered.connect(_on_hover_signal)
	GlobalSignals.mouse_clicked.connect(_on_click_signal)
