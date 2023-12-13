extends Node3D


var _anim_player: AnimationPlayer = null
var _anim_name: String


## Plays animation, if any
func play(playback_speed=1.0):
	if _anim_player:
		_anim_player.play(_anim_name, -1, playback_speed)


func setup():
	# check if any of it's child node requires animation playing
	
	var node: AnimationPlayer = find_child("AnimationPlayer", true, false)
	if not node:
		return
	
	_anim_player = node
	_anim_name = _anim_player.get_animation_list()[-1]
