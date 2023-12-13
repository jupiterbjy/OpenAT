extends Node3D


@onready var _sprites: Array[Sprite3D] = [
	$sprite_1,
	$sprite_2,
	$sprite_3,
	$sprite_4,
]
@onready var _mat: StandardMaterial3D = _sprites[0].material_override
var _texture = preload("res://Textures/Raw/Bullet.JPG")

var frame_idx: int = 12
var frame_end: int = 14


# so expensive, we'll need single model later on..
func assign_textures():
	_mat.texture = _texture
	
	for sprite in _sprites:
		sprite.texture = _texture


# Called when the node enters the scene tree for the first time.
func _ready():
	assign_textures()


func _process(delta):
	_mat.albedo_color.a = clamp(_mat.albedo_color.a - delta * 3, 0.0, 255.0)
	scale += Vector3(3, 0, 3) * delta


func _on_timer_timeout():
	if frame_end == frame_idx:
		queue_free()
		return
	
	frame_idx += 1
	for sprite in _sprites:
		sprite.frame = frame_idx
