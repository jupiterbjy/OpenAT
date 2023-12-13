extends MeshInstance3D


func _ready():
	# read setting and set accordingly
	visible = DebugManager.enabled
