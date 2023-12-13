extends Node3D


func _ready():
	var model = ModelLoader.load_name("FIELD")
	TextureLoader.set_mat(model, "FIRE")
	add_child(model)


func _process(delta):
	rotate_y(delta * 10.0)
