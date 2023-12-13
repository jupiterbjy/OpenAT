extends Node3D


@onready var turntable: Node3D = $turntable


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turntable.rotate_y(delta * -0.5)


func reload_loadout():
	turntable.load_loadout()
