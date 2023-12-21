extends Node3D


func _ready():
	MapSignals.hide_cursor.connect(hide)
	MapSignals.show_cursor.connect(show)
