extends Control


@onready var move_joystick = $movement_joystick
@onready var aim_joystick = $aim_joystick


## enable/disable joysticks when control scheme change signaled.
func on_aim_mode_changed(mode):
	if mode == ControlSystem.AIM_MODE.TOUCH:
		print("[ui_joystick] Enabling joysticks")
		move_joystick.set_process(true)
		aim_joystick.set_process(true)
	else:
		print("[ui_joystick] Disabling joysticks")
		move_joystick.set_process(false)
		aim_joystick.set_process(false)
		move_joystick.hide()
		aim_joystick.hide()


func _ready():
	ControlSystem.mode_changed.connect(on_aim_mode_changed)
	# run first manually
	on_aim_mode_changed(ControlSystem.mode)
