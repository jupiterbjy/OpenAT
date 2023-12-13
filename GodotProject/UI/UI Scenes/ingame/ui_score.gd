extends Control


@onready var timer: Timer = $score_up_timer


var format = ".... %s"

var current_idx = 0

var score_current = [
	0, 0, UserState.score
]
var score_until = [
	# tank item total
	ScoreSystem.score_tank,
	ScoreSystem.score_item,
	UserState.score + ScoreSystem.score_tank + ScoreSystem.score_item
]

@onready var labels = [
	$yellow_box_titled/VBoxContainer/HBoxContainer/Label3,
	$yellow_box_titled/VBoxContainer/HBoxContainer2/Label5,
	$yellow_box_titled/VBoxContainer/HBoxContainer3/Label6,
]

@onready var effect_points = [
	$yellow_box_titled/VBoxContainer/HBoxContainer/Label3/spawn_point,
	$yellow_box_titled/VBoxContainer/HBoxContainer2/Label5/spawn_point2,
	$yellow_box_titled/VBoxContainer/HBoxContainer3/Label6/spawn_point3,
]
var done = false



var score_particle = preload("res://EffectSystem/score_particle.tscn")


func pad_num(num: int, pad_lenght: int = 10) -> String:
	var string = str(num)
	
	return "..".repeat(10 - len(string)) + " " + string


func update_until():
	if current_idx >= 3:
		done = true
		return
	
	if score_current[current_idx] < score_until[current_idx]:
		score_current[current_idx] += 1
		
		labels[current_idx].text = pad_num(score_current[current_idx])
		effect_points[current_idx].add_child(score_particle.instantiate())
		
		timer.start(0.1)
	else:
		current_idx += 1
		update_until()


func skip():
	done = true
	for idx in range(3):
		labels[idx].text = pad_num(score_until[idx])


func _on_ok_button_button_clicked():
	if MapJsonLoader.current_area == 13:
		# play ending!
		UISignals.request_ui.emit(UIEnum.ENDING)
	else:
		UISignals.request_ui.emit(UIEnum.MAP_SELECT)
		SceneSignals.request_scene.emit(SceneManager.LEVEL)
		CamSignals.request_cam.emit(CamManager.FOLLOW)
		MapSignals.enter_demo.emit()
		# CamSignals.request_cam.emit(CamManager.ORBIT)
		# SceneSignals.request_scene.emit(SceneManager.OPENING)


func _input(event):
	if event.is_action_pressed("fire") and not done:
		timer.stop()
		skip()


func _ready():
	for idx in range(3):
		labels[idx].text = pad_num(score_current[idx])
	
	timer.start(0.1)


func _on_score_up_timer_timeout():
	update_until()
