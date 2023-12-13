extends GPUParticles3D

var _explosion_obj: Node3D
var _explosion_mat: StandardMaterial3D


func _setup_explosion_light():
	_explosion_obj = ModelLoader.load_name("EXPLIGHT")
	TextureLoader.set_mat(_explosion_obj, "FLASH")
	
	var mesh: MeshInstance3D = _explosion_obj.get_child(0)
	_explosion_mat = mesh.material_override.duplicate(true)
	_explosion_mat.transparency = _explosion_mat.TRANSPARENCY_ALPHA
	_explosion_mat.cull_mode = _explosion_mat.CULL_DISABLED
	
	mesh.material_override = _explosion_mat
	_explosion_obj.scale.y = 0.01
	add_child(_explosion_obj)


func _ready():
	_setup_explosion_light()
	emitting = true


func _on_timer_timeout():
	queue_free()


func _process(delta):
	_explosion_mat.albedo_color.a = clamp(_explosion_mat.albedo_color.a - delta * 2, 0.0, 255.0)
	_explosion_obj.scale += Vector3(-0.12, 0.0, 0.12) * delta
