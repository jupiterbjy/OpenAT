extends Node3D


static var _trail: PackedScene = preload("res://TankSystem/trails/trail_base.tscn")


func parse_json():
	# Dummy function for interface only
	pass


func on_trail_request(pos: Vector2, action, facing):
	var trail: Trail = _trail.instantiate()
	
	trail.pre_ready_setup(action, facing)
	trail.position = Vector3(pos.x, 0.01, pos.y)
	
	add_child(trail)


func _ready():
	MapSignals.spawn_trail.connect(on_trail_request)
