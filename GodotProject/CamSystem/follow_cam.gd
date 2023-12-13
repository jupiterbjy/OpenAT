class_name FollowCam
extends Node3D


@onready var cam: Camera3D = $cam

var _follow_speed: float = 4.0
var _follow_target: Node3D = null


## sets follow target
func set_target(tank: PlayerTank):
	print("[FollowCam] Target set to %s" % tank)
	_follow_target = tank


func get_player_tank():
	var level: Level = SceneSignals.current_scene.get_child(0)
	return level.respawns.player_ref


# not sure if I should use physics_process or process, I bet this is easy on device enough.
func _process(delta):
	
	# this feels wayy expensive, but player tanks do die in demo scenes.
	if _follow_target == null:
		return
	
	global_position = global_position.lerp(_follow_target.global_position * 0.5, delta)


func _ready():
	MapSignals.player_spawned.connect(set_target)
