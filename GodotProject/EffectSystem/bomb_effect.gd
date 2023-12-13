extends Node3D

func _ready():
	var model = ModelLoader.load_name("EFFBOMB")
	TextureLoader.set_mat(model, "FIRE")
	add_child(model)


func _process(delta):
	rotate_y(delta * 5.0)


func _on_timer_timeout():
	queue_free()
