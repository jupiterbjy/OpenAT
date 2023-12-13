extends "res://TankSystem/base/weapon_subsystem.gd"


var _mouse_plate: Area3D
var _offset: Vector3

func _update_aim():
	var pos = Raycasts.raycast_get_aim_point()
	
	if not pos:
		return
	
	_level.get_child(5).position = pos / 1.1
	_root.head_root.look_at(pos)


func fire():
	if _is_in_cooltime:
		return
	
	_is_in_cooltime = true
	
	
	_model_root.play(1 / _root.reload)
	
	var projectile: BaseProjectile = _projectile.instantiate()
	projectile.pre_ready_setup(_upgrades, _is_allie, _fire_root)
	_level.add_child(projectile)
	
	_timer.start(_root.reload)


func _process(_delta):
	if _root.autonomous:
		return
	
	_update_aim()
	
	if Input.get_action_strength("fire"):
		fire()


func _adjust_offset():
	var size = MapJsonLoader.current_loaded["size"]
	_offset.x = -0.5 if int(size[0]) & 1 else 0
	_offset.z = 0.5 if int(size[1]) & 1 else 0


func _ready():
	var size = MapJsonLoader.current_loaded["size"]
	# _adjust_offset()
