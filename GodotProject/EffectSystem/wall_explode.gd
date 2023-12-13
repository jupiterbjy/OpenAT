extends Node3D


var _model: Node3D
var _mat: StandardMaterial3D


# Called when the node enters the scene tree for the first time.
func _ready():
	_model = ModelLoader.load_name("EXPWALL")
	
	TextureLoader.set_mat(_model, "FIRE")
	
	var mesh: MeshInstance3D = _model.get_child(0)
	
	_mat = mesh.material_override.duplicate(true)
	_mat.transparency = _mat.TRANSPARENCY_ALPHA
	_mat.cull_mode = _mat.CULL_DISABLED
	mesh.material_override = _mat
	
	add_child(_model)


func _process(delta):
	_mat.albedo_color.a = clamp(_mat.albedo_color.a - delta * 5, 0.0, 255.0)
	_model.scale += Vector3(-0.2, 0, 0.2) * delta


func _on_timer_timeout():
	queue_free()
