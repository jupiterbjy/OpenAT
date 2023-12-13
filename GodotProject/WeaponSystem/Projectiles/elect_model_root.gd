extends Node3D


# this messy script is to mimic variable length & animated behavior of electro.
# if Sprite3D support ADD blend mode, all this can be implemented in 2 animation player.


@onready var _extension: Node3D = $extension
@onready var _timer: Timer = $model_change_timer

static var _model_cache: Dictionary = {}
static var _format: String = "res://Models/Custom/lightning/Bullet_Electro_%03d.glb"

signal animation_done

var _raw_length: float
var _length_idx: int
var _current_loaded = null
var _current_loaded_extension = null

var effect_scene: PackedScene = preload("res://EffectSystem/electro_eff.tscn")


func spawn_effect():
	var offset: Node3D = SceneSignals.current_scene.get_child(0).get_child(0)
	
	for n in range(_length_idx / 2):
		var eff: GPUParticles3D = effect_scene.instantiate()
		eff.emitting = true
		
		# set relative distance
		add_child(eff)
		eff.position.z = - (n * 2 - randf_range(0.0, 0.5)) * 10
		eff.position.x = randf_range(-10, 10)


func determine_length_idx(length: float):
	_raw_length = length
	_length_idx = clamp(round(length * 2.5), 0, 16)


func _load_model(model_idx) -> Node3D:
	if model_idx not in _model_cache:
		_model_cache[model_idx] = load(_format % model_idx)
	
	var obj = _model_cache[model_idx].instantiate()
	TextureLoader.set_mat(obj, "BLIGHT")
	
	spawn_effect()
	
	return obj


func _remove_models():
	if _current_loaded:
		_current_loaded.queue_free()
		
		# making sure this is set to null, or will get 'previous freed' object
		_current_loaded = null
	
	if _current_loaded_extension:
		_current_loaded_extension.queue_free()
		_current_loaded_extension = null


func _setup_models():
	if _length_idx >= 9:
		# need full length one and one more
		_current_loaded = _load_model(_repeat_count * 9 + 8)
		_current_loaded_extension = _load_model(_repeat_count * 9 + _length_idx - 9)
		
		add_child(_current_loaded)
		_extension.add_child(_current_loaded_extension)
		return
	
	_current_loaded = _load_model(_repeat_count * 9 + _length_idx)
	add_child(_current_loaded)


var _repeat_count = 0


func _on_model_change_timer_timeout():
	_remove_models()
	
	if _repeat_count > 4:
		animation_done.emit()
		return
	
	_setup_models()
	_repeat_count += 1
	
	_timer.start(0.1)


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_model_change_timer_timeout.call_deferred()
