extends Node3D


var _rotate_speed: float = -0.11

@onready var _turntable: Node3D = $turntable


func _ready():
	var _mapping = [
		[$turntable/logo_terrain, "TERR", ""],
		[$turntable/Terr_14, "TERR", ""],
		[$turntable/Terr_14_2, "TERR", ""],
		[$turntable/Terr_14_3, "TERR", ""],
		[$turntable/Terr_14_4, "TERR", ""],
		[$turntable/Terr_14_5, "TERR", ""],
		[$turntable/Terr_16, "TERR2", ""],
		[$turntable/Terr_17, "TERR2", ""],
		[$turntable/terr_59, "TERR2", ""],
		[$turntable/Terr_85, "TERR2", "texture-dung"],
		[$turntable/Terr_87, "TERR2", "texture-dung"],
		[$turntable/Tank_Player, "TANKPL1", ""],
	]
	
	for idx in range(len(_mapping)):
		TextureLoader.set_mat(_mapping[idx][0], _mapping[idx][1], _mapping[idx][2])


func _process(delta):
	_turntable.rotate_y(delta * _rotate_speed)
