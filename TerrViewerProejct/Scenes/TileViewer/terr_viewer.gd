extends Node3D


@export var rotate_speed = 2.0

@onready var _turntable = $turntable
@onready var _default_transform = _turntable.transform

@onready var _label: Label = $VBoxContainer/Control/blue_box/HBoxContainer/Label

@onready var _tex_label: Label = $blue_box2/VBoxContainer/Label2
@onready var _texture: TextureRect = $blue_box2/VBoxContainer/HBoxContainer2/texture

@onready var _cams: Array[Camera3D] = [$cam, $SubViewportContainer2/SubViewport/cam2]
@onready var _cam_default_poses = [_cams[0].position, _cams[1].position]
@onready var _cam_min_poses = [_cams[0].position * 0.5, _cams[1].position * 0.5]
@onready var _cam_max_poses = [_cams[0].position * 3.0, _cams[1].position * 3.0]

@onready var _compass = $SubViewportContainer/SubViewport/compass

var _idx_cap = 110 + 1
var _current_idx = 0
var _current_obj: Node3D = null

var _mat_idx = 0
var _mat_list: Array[StandardMaterial3D] = [
	load("res://Materials/Terr_Forest_Pac.tres"),
	load("res://Materials/Terr_Forest_Pac_Obj.tres"),
	load("res://Materials/Terr_Sand_Pac.tres"),
	load("res://Materials/Terr_Sand_Pac_Obj.tres"),
	load("res://Materials/Terr_Snow.tres"),
	load("res://Materials/Terr_Egypt.tres"),
	load("res://Materials/Terr_Egypt_Obj.tres"),
	load("res://Materials/Terr_Ice.tres"),
	load("res://Materials/Terr_Fire.tres"),
	load("res://Materials/Terr_Tundra.tres"),
	load("res://Materials/Terr_Dung.tres"),
	load("res://Materials/Terr_Grot.tres"),
]


func _forward_selection():
	# some resources are missing, we need to check one by one

	for idx in range(_current_idx + 1, _idx_cap):
		
		if ModelLoader.exists("TERR%s" % idx):
			# we have resource!
			_current_idx = idx
			print("Found idx %s" % _current_idx)
			return
		
	# we couldn't find next one, we're at end of idx, set to first one
	_current_idx = 0


func _backward_selection():
	for idx in range(_current_idx - 1, 0, -1):

		if ModelLoader.exists("TERR%s" % idx):
			# we have resource!
			_current_idx = idx
			print("Found idx %s" % _current_idx)
			return
		
	# we couldn't find next one, we're at start of idx, set to last one
	_current_idx = _idx_cap - 1


## Set label & load resource at current idx. Drop previous model if any
func _load_resource():
	_label.text = "TERR%s" % _current_idx
	
	if _current_obj != null:
		_current_obj.queue_free()
	
	# load resource
	_current_obj = ModelLoader.load_name(_label.text)
	
	# update texture
	_set_texture()
	
	# add to child
	_turntable.add_child.call_deferred(_current_obj)


## Set texture
func _set_texture():
	_current_obj.get_child(0).set_material_override(_mat_list[_mat_idx])
	_texture.texture = _mat_list[_mat_idx].albedo_texture
	
	var text = _mat_list[_mat_idx].resource_path.split("/")[-1]
	_tex_label.text = text.split(".")[0]


## Set next texture
func _forward_texture():
	_mat_idx = (_mat_idx + 1) % len(_mat_list)
	_set_texture()


## Set previosu texture
func _backward_texture():
	_mat_idx = (_mat_idx - 1) % len(_mat_list)
	_set_texture()


func _ready():
	_load_resource()
	_on_grid_show_button_button_clicked()


func reset_cam():
	_turntable.transform = _default_transform
	_cams[0].position = _cam_default_poses[0]
	_cams[1].position = _cam_default_poses[1]
	
	_compass.reset_pointer()


func rotate_view(amount):
	_turntable.rotate_y(amount)
	_compass.rotate_pointer(amount)


func zoom(action):
	for idx in [0, 1]:
		_cams[idx].position += action * _cam_default_poses[idx] * 0.1
		_cams[idx].position = clamp(
			_cams[idx].position, _cam_min_poses[idx], _cam_max_poses[idx]
		)


func _process(delta):
	
	# right - left key changes cam's X axis (which actually turn in Y axis)
	var action = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if action:
		_turntable.rotate_y(action * rotate_speed * delta)


var events: Dictionary = {}
var last_drag_dist: float = 0.0
var is_in_zoom: bool = false


func _unhandled_input(event):
	# ref: https://kidscancode.org/godot_recipes/3.x/2d/touchscreen_camera/index.html
	
	if event is InputEventScreenTouch:
		if event.double_tap:
			reset_cam()
			return
		
		if event.pressed:
			print(events)
			events[event.index] = event
		else:
			events.erase(event.index)
			is_in_zoom = false
	
	# pan model rotation
	if event is InputEventScreenDrag:
		events[event.index] = event
		
		match events.size():
			1:
				rotate_view(event.relative.x / 100.0)
			2:
				var drag_dist = events.values()[0].position.distance_to(events.values()[1].position)
				
				# previously was not in zoom, init last dist
				if not is_in_zoom:
					last_drag_dist = drag_dist
					is_in_zoom = true
					return
				
				var diff = drag_dist - last_drag_dist
				if abs(diff) > 0:
					zoom(-diff / 10.0)
					
				last_drag_dist = drag_dist
			3:
				reset_cam()
				events.clear()
	
	# reset view if reset_cam pressed
	if Input.get_action_strength("reset_cam"):
		reset_cam()
	
	# zoom
	var action = Input.get_action_strength("zoom_out") - Input.get_action_strength("zoom_in")
	if action:
		zoom(action)


func _on_left_pressed():
	_backward_selection()
	_load_resource()


func _on_right_pressed():
	_forward_selection()
	_load_resource()


func _on_screenshot_button_button_clicked():
	var img = get_viewport().get_texture().get_image()
	img.save_png("./terr_%s.png" % _current_idx)


func _on_tex_left_pressed():
	_backward_texture()


func _on_tex_right_pressed():
	_forward_texture()


var _current_no_depth_test: bool = true
var _materials: Array[StandardMaterial3D] = [
	preload("res://Materials/_x.tres"),
	preload("res://Materials/_y.tres"),
	preload("res://Materials/_xy.tres"),
	preload("res://Materials/box.tres"),
]


## Disable depth test so materials can be seen-thru over objects
func _on_grid_show_button_button_clicked():
	_current_no_depth_test = not _current_no_depth_test
	
	for mat in _materials:
		mat.no_depth_test = _current_no_depth_test
