class_name IngameCam
extends Node3D


@onready var cam: Camera3D = $cam
@onready var player: AnimationPlayer = $player


enum {INGAME, INGAME_TOP, INGAME_PAUSED}
@onready var cam_modes: Array = [
	# Pos, Rotation(Eular in rad), FOV, projection
	[
		$cam_gizmo_default.position,
		$cam_gizmo_default.rotation,
		30.0,
		cam.PROJECTION_PERSPECTIVE,
	],
	[
		$cam_gizmo_top.position,
		$cam_gizmo_top.position,
		10.0,
		cam.PROJECTION_ORTHOGONAL
	],
	[
		$cam_gizmo_pause.position,
		$cam_gizmo_pause.position,
		44.0,
		cam.PROJECTION_PERSPECTIVE
	],
]

var _current_mode = INGAME_PAUSED


## Smooth camera transition to given mode
func make_transition(mode_enum):
	
	match [_current_mode, mode_enum]:
		[INGAME, INGAME_PAUSED]:
			player.play("def_to_pause")
		
		[INGAME_PAUSED, INGAME]:
			player.play("pause_to_def")
		
		[INGAME, INGAME_TOP]:
			player.play("def_to_top", -1, 2.0)
		
		[INGAME_TOP, INGAME]:
			player.play("def_to_top", -1, -2.0, true)
		
		[INGAME_TOP, INGAME_PAUSED]:
			player.play("pause_to_top", -1, -3.0, true)
			
		[INGAME_PAUSED, INGAME_TOP]:
			player.play("pause_to_top", -1, 3.0)
	
	_current_mode = mode_enum


## Change ingame cam mode
func change_mode(mode):
	print("[IngameCam] Changing Mode from %s to %s" % [_current_mode, mode])
	# find way to blend this? maybe no orthogonal and move camera far back?
	
	if not cam.current:
		print("[IngameCam] Camera not active")
	
	make_transition(mode)


var _cycle_idx = 3
var _cycle = [INGAME_TOP, INGAME, INGAME_PAUSED, INGAME]


func _input(event):
	if event.is_action_released("switch_cam"):
		if get_tree().paused:
			return
		
		_cycle_idx = (_cycle_idx + 1) % 4
		change_mode((_cycle[_cycle_idx]))
