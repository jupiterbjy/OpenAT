# ref: https://www.gdquest.com/tutorial/godot/audio/background-music-transition/

extends Node


enum {MUSIC_MENU, MUSIC_GAME}


## Pair of animation name & index of stream.
## If a animation is finished, it's value is faded out stream's idx
var _animation_stream_pairs = {"FadeTo1": 1, "FadeTo2": 0}
var _fading_to: int = -1


@onready var _animation_player = $crossfade_audio
@onready var _streams: Array[AudioStreamPlayer] = [$audio_player_1, $audio_player_2]


## pause inactive stream after playback is finished.
func _on_crossfade_audio_animation_finished(animation_name):
	print("[GlobalMusicManager] Playback of %s finished" % animation_name)
	var inactive = _streams[_animation_stream_pairs[animation_name]]
	inactive.stream_paused = true
	_fading_to = -1


func crossfade_to(music_id):
	# print("[GlobalMusicManager] Crossfade requested to %s" % music_id)
	
	var position = 0.0
	
	# if two tracks are playing, it's already in transition
	if _streams[MUSIC_MENU].playing and _streams[MUSIC_GAME].playing:
		
		# if existing trainsition is already in transit to target, pass
		if music_id == _fading_to:
			print("[GlobalMusicManager] Already Crossfading to %s" % _fading_to)
			return
		
		# otherwise cache position and reverse animation.
		# no need for play_backwards as we only have 2 soundtracks so far
		print("[GlobalMusicManager] Canceling active crossfade to %s" % _fading_to)
		position = 2.0 - _animation_player.current_animation_position
	
	elif _streams[music_id].playing:
		# if target is already fully playing, pass
		return
	
	else:
		# if other song is fully playing, resume target
		_streams[music_id].stream_paused = false
	
	# crossfade
	print("[GlobalMusicManager] Crossfading to %s position %s" % [music_id, position])
	_fading_to = music_id
	_animation_player.play(_animation_stream_pairs.keys()[music_id])
	_animation_player.seek(position)


func _ready():
	for stream in _streams:
		stream.play()
		stream.stream_paused = true
	
	crossfade_to(MUSIC_MENU)
