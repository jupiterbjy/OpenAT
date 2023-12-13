extends Area3D


@onready var aim_gizmo = $aim_gizmo

var _raycast_cooldown: float


# TODO: remove this later
func _ready():
	Raycasts.update_raycast_params()


## Highlights tile selected by raycast
func _get_aim_pos():
	var collided = Raycasts.raycast_mouse(Raycasts.aim_mask)
	
	if collided:
		return collided["position"]

	return null



func _process(_delta):
	_raycast_cooldown += _delta
	
	if _raycast_cooldown > 0.01:
		_raycast_cooldown = 0.0
		
		var position = _get_aim_pos()
		if position != null:
			aim_gizmo.position = position
	
	if Input.get_action_strength("fire") != 0.0:
		pass
		
	if Input.get_action_strength("revert") != 0.0:
		pass
