extends Node3D


var _texture_name: String = "TANKENEMY"

# exploooosion!

func _on_cleanup():
	queue_free()


func setup(material_name: String):
	_texture_name = material_name


func _setup_tank_debris():
	var model = ModelLoader.load_name("TANKEXPL")
	TextureLoader.set_mat(model, _texture_name)
	
	var nodes = model.find_children("*", "AnimationPlayer")
	var _anim_player: AnimationPlayer = nodes[0]
	var _anim_name = _anim_player.get_animation_list()[-1]
	
	_anim_player.play(_anim_name, -1, 0.3)
	
	add_child(model)


func _ready():
	_setup_tank_debris()
	
	$explosion_paticle.emitting = true


func _on_timer_timeout():
	queue_free()
