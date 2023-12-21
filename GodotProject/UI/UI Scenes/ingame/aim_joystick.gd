## Handles Touch input events for aiming.

extends Sprite2D


@onready var _stick: Sprite2D = $aim_stick


## joystick status, for readability sake
var _joystick_active = false

## touch index
var _touch_idx: int

## joystick center coordinate
var _center: Vector2

## Limit travel distance of stick
var _limit_dist: float = 256

## Fire threshold travel distance
var _fire_dist: float = 256 * 0.8

## Scale to apply as joystick itself is scaled thus not 1:1 to coordination.
var _scale: float = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	_limit_dist *= scale.x
	_fire_dist *= scale.x
	_scale = 1 / scale.x
	
	self.hide()


func release_input():
	Input.action_release("aim_right")
	Input.action_release("aim_left")
	Input.action_release("aim_up")
	Input.action_release("aim_down")
	
	# Input.action_release("fire")


func send_input(action: String, strength: float):
	if Input.is_action_pressed(action):
		return
	
	Input.action_press(action, strength)


func parse_aim(joystick_pos: Vector2):
	release_input()
	
	if joystick_pos.x > 0:
		send_input("aim_right", joystick_pos.x)
	
	else:
		send_input("aim_left", -joystick_pos.x)
	
	if joystick_pos.y > 0:
		# y is reversed
		send_input("aim_down", joystick_pos.y)
		
	else:
		send_input("aim_up", -joystick_pos.y)


func _input(event):
	# every drag event is prefixed & suffixed by a touch event.
	# suffix one being pressed=false.
	
	if event is InputEventScreenTouch:
		if event.is_pressed():
			
			# if not our area or already active ignore
			if event.position.x < 512.0 or _joystick_active:
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
				
				ControlSystem.touch_fire = false
				ControlSystem.touch_aim = Vector2(0, 0)
				
				_joystick_active = false
				self.hide()
				
		return
	
	if event is InputEventScreenDrag and _joystick_active and event.index == _touch_idx:
		var diff: Vector2 = event.position - _center
		
		var dist: float = _center.distance_to(event.position)
		var multiplier: float = _limit_dist / dist if dist > _limit_dist else 1.0
		
		_stick.position = diff * _scale * multiplier

		# will emit input signal for each. This means we have 1-frame input lag!
		parse_aim(diff / _limit_dist)
		
		# if dist > _fire_dist and not Input.is_action_pressed("fire"):
		#	Input.action_press("fire")
		
		ControlSystem.touch_fire = dist > _fire_dist
