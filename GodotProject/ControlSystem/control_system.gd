extends Node


@onready var timer: Timer = $switch_to_mouse_timer

enum AIM_MODE {MOUSE, TOUCH, JOYSTICK}
var mode: AIM_MODE = AIM_MODE.MOUSE

signal mode_changed(mode: AIM_MODE)


## touch aim vector from ui_joystick
var touch_aim: Vector2

## touch fire state from ui_joystick
var touch_fire: bool


func _input(event):
	# can't use is compare in match
	
	# detemine aim control scheme by input mode
	if event is InputEventJoypadMotion:
		
		# reset mouse control switch timmer
		timer.start(2.0)
		
		if mode != AIM_MODE.JOYSTICK:
			mode = AIM_MODE.JOYSTICK
			print("[ControlSystem] Enabling Controller mode")
			mode_changed.emit(mode)
	
	elif event is InputEventScreenDrag or event is InputEventScreenTouch:
		timer.start(2.0)
		
		if mode != AIM_MODE.TOUCH:
			print("[ControlSystem] Enabling Touch mode")
			mode = AIM_MODE.TOUCH
			mode_changed.emit(mode)
	
	elif event is InputEventMouseMotion:
		
		if timer.is_stopped() and mode != AIM_MODE.MOUSE:
			print("[ControlSystem] Enabling Mouse mode")
			mode = AIM_MODE.MOUSE
			mode_changed.emit(mode)


func is_controller_aim_active():
	return (
		bool(Input.get_action_strength("aim_right"))
		or bool(Input.get_action_strength("aim_left"))
		or bool(Input.get_action_strength("aim_up"))
		or bool(Input.get_action_strength("aim_down"))
	)


func get_controller_aim() -> Vector3:
	# up down axis has to be in reverse
	return Vector3(
		Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left"),
		0,
		Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	)


func _ready():
	# delay this because _input() runs before this for some reason.
	process_mode = Node.PROCESS_MODE_ALWAYS
