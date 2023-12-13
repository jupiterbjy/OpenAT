class_name WeaponSubsystem extends Node

@onready var _timer = $fire_cooltime
@onready var _root = get_owner()

var _is_in_cooltime: bool = false
static var is_locked: bool = false

var _projectile: PackedScene

var _fire_root: Node3D
var _model_root: Node3D

var _is_allie: bool
var _scan_mask: int

var _level = SceneSignals.current_scene.get_child(0)
var _upgrades: Array
var _fire_interval_min: float


func post_ready_setup(weapon_type, tank_type):
	_model_root = get_owner().get_child(0)
	_fire_root = _model_root.get_child(0).get_child(0)
	_upgrades = get_owner().upgrades
	
	_projectile = WeaponData.entries[weapon_type]
	
	_is_allie = tank_type == get_owner().TYPE.ALLIE
	
	if _is_allie:
		_scan_mask = Raycasts.allie_target_mask
	else:
		_scan_mask = Raycasts.enemy_target_mask
		_root.reload *= Difficulty.multiplier[Difficulty.difficulty]
	
	_fire_interval_min = Difficulty.multiplier[Difficulty.difficulty] * _root.reload / 2.0


func fire():
	if _is_in_cooltime:
		return
	
	_is_in_cooltime = true
	
	_model_root.play(1 / _root.reload)
	
	var projectile: BaseProjectile = _projectile.instantiate()
	projectile.pre_ready_setup(_upgrades, _is_allie, _fire_root)
	_level.add_child(projectile)
	
	_timer.start(randi_range(_fire_interval_min, _root.reload))


func start():
	_timer.start(0.1)


func _on_fire_cooltime_timeout():
	_is_in_cooltime = false
	
	if not _root.autonomous:
		return
	
	if is_locked:
		_timer.start(1.0)
		return
	
	if Raycasts.is_target_in_sight(_fire_root, _scan_mask):
		fire()
		return
	
	_timer.start(0.1)
