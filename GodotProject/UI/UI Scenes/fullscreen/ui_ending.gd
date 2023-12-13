extends Control


var firework_scene: PackedScene = preload("res://EffectSystem/firework_main.tscn")
var _area: Array[int] = [100, 900, 500, 600]

@onready var timer: Timer = $timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(0.1)
	GlobalState.leaderboards.append([UserState.user_name, UserState.score])
	GlobalState.save_json()


func _on_timer_timeout():
	var firework: GPUParticles2D = firework_scene.instantiate()
	
	firework.position = Vector2(randi_range(_area[0], _area[1]), randi_range(_area[2], _area[3]))
	add_child(firework)
	
	timer.start(randi_range(1.0, 3.0))


func _on_ok_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.HIGHSCORE)
	SceneSignals.request_scene.emit(SceneManager.OPENING)
	CamSignals.request_cam.emit(CamManager.ORBIT)
