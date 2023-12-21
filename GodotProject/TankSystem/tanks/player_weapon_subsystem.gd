extends "res://TankSystem/base/weapon_subsystem.gd"


var _mouse_plate: Area3D
var _offset: Vector3
var aim_func: String = "_aim_mouse"


func _aim_mouse():
	var pos = Raycasts.raycast_get_aim_point()
	
	if not pos:
		return
	
	_root.head_root.look_at(pos)
	
	# move mouse track pointer, dividing 1.1 which is xz scale applied to _level.
	_level.get_child(5).position = pos / 1.1


func _aim_controller():
	if not ControlSystem.is_controller_aim_active():
		MapSignals.hide_cursor.emit()
		return
	
	MapSignals.show_cursor.emit()
	var pos = ControlSystem.get_controller_aim().normalized() * 2
	pos += _root.global_position
	
	_root.head_root.look_at(pos)
	_level.get_child(5).position = pos / 1.1


func _aim_touch():
	pass


# bug here: https://github.com/godotengine/godot/issues/73109
func on_aim_mode_change(aim_mode):
	
	match aim_mode:
		ControlSystem.AIM_MODE.MOUSE:
			print("[PlayerWeaponSubsystem] Changing to mouse")
			MapSignals.show_cursor.emit()
			aim_func = "_aim_mouse"
		
		# use controller for touch, as touch will emulate those for now
		ControlSystem.AIM_MODE.TOUCH:
			print("[PlayerWeaponSubsystem] Changing to touch")
			aim_func = "_aim_controller"
		
		ControlSystem.AIM_MODE.JOYSTICK:
			print("[PlayerWeaponSubsystem] Changing to joystick")
			aim_func = "_aim_controller"


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
	# wish I can remove this check..
	if _root.autonomous:
		return
	
	call(aim_func)
	
	if ControlSystem.mode != ControlSystem.AIM_MODE.TOUCH:
		if Input.get_action_strength("fire"):
			fire()
	else:
		if ControlSystem.touch_fire:
			fire()


func _adjust_offset():
	var size = MapJsonLoader.current_loaded["size"]
	_offset.x = -0.5 if int(size[0]) & 1 else 0.0
	_offset.z = 0.5 if int(size[1]) & 1 else 0.0


func _ready():
	var size = MapJsonLoader.current_loaded["size"]
	# _adjust_offset()
	
	ControlSystem.mode_changed.connect(on_aim_mode_change)
	# run manually once
	on_aim_mode_change(ControlSystem.mode)
