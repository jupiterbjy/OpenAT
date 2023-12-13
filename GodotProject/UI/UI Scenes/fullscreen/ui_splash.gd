extends Control


@onready var player: AnimationPlayer = $player


## skips a section of the animation
func _skip_animation():
	for zone in [3.0, 8.0]:
		
		var playback = player.current_animation_position
		
		if playback < zone:
			player.seek(zone)
			return


func _ready():
	print("[ui_splash] Started")
	player.play("fade_in")


# request main UI and opening scene
func _on_player_animation_finished(_anim_name):
	if UserState.require_new_user:
		UISignals.request_ui.emit(UIEnum.NEW_USER)
	else:
		UISignals.request_ui.emit(UIEnum.MAIN_MENU)
	
	SceneSignals.request_scene.emit(SceneManager.OPENING)
	CamSignals.request_cam.emit(CamManager.ORBIT)


func _input(event):
	if event.get_action_strength("fire"):
		_skip_animation()
