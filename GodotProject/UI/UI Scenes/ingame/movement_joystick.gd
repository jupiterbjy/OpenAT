## Handles Touch input events for movements.

extends Sprite2D


@onready var _stick: Sprite2D = $movement_stick

## joystick status, for readability sake
var _joystick_active = false

## touch index
var _touch_idx: int

## joystick center coordinate
var _center: Vector2

## Limit travel distance of stick
var _limit_dist: float = 256.0

## Scale to apply as joystick itself is scaled thus not 1:1 to coordination.
var _scale: float = 1.0

## Deadzone radius
var _deadzone: float = 64.0


func _ready():
	_limit_dist *= scale.x
	_deadzone *= scale.x
	_scale = 1 / scale.x
	
	self.hide()


## Releases all inputs.
func release_input():
	Input.action_release("move_right")
	Input.action_release("move_left")
	Input.action_release("move_up")
	Input.action_release("move_down")


func send_input(action: String):
	if Input.is_action_pressed(action):
		return
	
	release_input()
	Input.action_press(action)


## Parses angle and sends input.
func parse_angle(radian_angle: float):
	# wrapped in parenthesis for clarity in my bad eyes
	# this might need more optimization...
	
	if radian_angle == 0.0:
		return
	
	# right
	if (-PI / 4 < radian_angle) and (radian_angle < PI / 4):
		send_input("move_right")
	
	# left
	elif (3 * PI / 4 < radian_angle) or (radian_angle < -3 * PI / 4):
		send_input("move_left")
	
	# up
	elif (-3 * PI / 4 < radian_angle) and (radian_angle < -PI / 4):
		send_input("move_up")
	
	# down
	else:
		send_input("move_down")


func _input(event):
	# every drag event is prefixed & suffixed by a touch event.
	# suffix one being pressed=false.
	
	if event is InputEventScreenTouch:
		if event.is_pressed():
			
			# if not our area or already active ignore
			if event.position.x >= 512.0 or _joystick_active:
				return
			
			# if it's in our side start joystick.
			_touch_idx = event.index
			_joystick_active = true
			
			_center = event.position
			self.show()
			
			self.position = _center
			_stick.position = Vector2(0, 0)
		
		else:	
			# if our tab released - remove joystick, if that was our side's touch.
			if event.index == _touch_idx:
				_touch_idx = -1
				release_input()
				
				_joystick_active = false
				self.hide()
				
		return
	
	if event is InputEventScreenDrag and _joystick_active and event.index == _touch_idx:
		var dist = _center.distance_to(event.position)
		var multiplier = (_limit_dist / dist) * _scale if dist > _limit_dist else _scale
		_stick.position = (event.position - _center) * multiplier

		if dist < _deadzone:
			release_input()
			return
		
		# will emit input signal for each. This means we have 1-frame input lag!
		parse_angle(_center.angle_to_point(event.position))
