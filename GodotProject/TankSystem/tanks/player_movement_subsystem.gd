extends MovementSubsystem


func move_direction(target_facing: FACING):

	# if facing is not same, we need to turn
	if target_facing != _current_facing:
		turn(target_facing)
	else:
		forward()


#func _unhandled_key_input(event):
#	if _root.autonomous or in_movement:
#		return
#
#	if event.get_action_strength("move_up"):
#		move_direction(FACING.NORTH)
#
#	elif event.get_action_strength("move_down"):
#		move_direction(FACING.SOUTH)
#
#	elif event.get_action_strength("move_left"):
#		move_direction(FACING.WEST)
#
#	elif event.get_action_strength("move_right"):
#		move_direction(FACING.EAST)



func _process(_delta):
	if _root.autonomous or in_movement:
		return
	
	# reset stack
	_current_block_count = 0
	
	# there's around 0.2~0.5 sec latency in _Input/_Unhandledinput for this one.
	# not sure why only this but using process instead for now.
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_up") - Input.get_action_strength("move_down")
	
	# choose which axis to take
	if abs(x) > abs(y):
		if x > 0:
			move_direction(FACING.EAST)
		elif x < 0:
			move_direction(FACING.WEST)
	else:
		if y > 0:
			move_direction(FACING.NORTH)
		elif y < 0:
			move_direction(FACING.SOUTH)
