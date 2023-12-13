class_name HealthBar
extends Node3D

var health: int = 100
var health_max: int = 100
var is_invincible: bool = false

var _current_bar: Node3D = null
var _current_bar_type: String = ""


signal destroyed
signal hit


func setup(_health: int):
	health = _health
	health_max = _health


func _build_healthbar(model_name: String):
	
	# remove any previous bar
	if _current_bar:
		_current_bar.queue_free()
	
	# load & set material
	var obj = ModelLoader.load_name(model_name)
	TextureLoader.set_mat(obj, "TANKENEMY")
	
	add_child(obj)
	
	_current_bar = obj
	_current_bar_type = model_name


func set_healthbar():
	# for 100% 0%
	if health == health_max or health <= 0:
		# if there's healthbar, remove it
		if _current_bar:
			_current_bar.queue_free()
			_current_bar = null
		
		_current_bar_type = ""
	
	# for 90% 70% 50% 30% 10%
	for health_bound in [9, 7, 5, 3, 1]:
		if health > health_max * health_bound / 10:
			var bar_type: String = "TL%s0" % health_bound
			
			if _current_bar_type != bar_type:
				_build_healthbar(bar_type)
			
			break


func get_ratio() -> float:
	return health / float(health_max)


## Damage health. Returns True if still alive, else False
func get_damage(damage: int):
	if is_invincible:
		return
	
	health = clamp(health - damage, 0, health_max)
	set_healthbar()
	
	hit.emit()
	
	var is_alive = health < 1
	if is_alive:
		destroyed.emit()
	
	return is_alive
