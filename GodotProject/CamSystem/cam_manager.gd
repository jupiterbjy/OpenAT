class_name CamManager
extends Node3D


@onready var orbit_cam: OrbitCam = $orbit_view_cam
@onready var follow_cam: FollowCam = $follow_cam
@onready var ingame_cam: IngameCam = $ingame_cam


enum {ORBIT, FOLLOW, INGAME, INGAME_TOP, INGAME_PAUSED}
@onready var _current_active_cam = orbit_cam


## Replace active camera if it's not already set
func _replace_active(cam_scene):
	if cam_scene == _current_active_cam:
		return
	
	cam_scene.show()
	cam_scene.cam.make_current()
	
	if _current_active_cam != null:
		_current_active_cam.hide()
	
	_current_active_cam = cam_scene


## Switch cam mode
func switch_cam(mode_enum):
	print("[CamManager] Replacing cam to %s" % mode_enum)
	
	match mode_enum:
		ORBIT:
			_replace_active(orbit_cam)
		
		FOLLOW:
			_replace_active(follow_cam)
		
		INGAME, INGAME_TOP, INGAME_PAUSED:
			_replace_active(ingame_cam)
			ingame_cam.change_mode(mode_enum - 2)


func _ready():
	CamSignals.request_cam.connect(switch_cam)
