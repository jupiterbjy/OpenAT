extends Node3D


var tile_pos: Vector2


static var _item_scenes: Dictionary = {
	"C": preload("res://ItemSystem/Items/item_c.tscn"),
	"S": preload("res://ItemSystem/Items/item_s.tscn"),
	"M": preload("res://ItemSystem/Items/item_m.tscn"),
	"L": null, # preload("res://ItemSystem/Items/item_l.tscn"),
	"Z": preload("res://ItemSystem/Items/item_z.tscn"),
	"R": preload("res://ItemSystem/Items/item_r.tscn"),
	"B": null, # preload("res://ItemSystem/Items/item_b.tscn"),
	"I": null, # preload("res://ItemSystem/Items/item_i.tscn"),
	"X": preload("res://ItemSystem/Items/item_x.tscn"),
}


func generate_item():
	var items: String = MapJsonLoader.current_loaded["items"]
	var item: String = items[randi_range(0, len(items) - 1)]
	
	var scene: PackedScene = _item_scenes[item]
	if not scene:
		return
	
	var model: Node3D = scene.instantiate()
	
	get_parent().add_child(model)
	model.position = position


func _ready():
	# load model, set texture and add child
	var model = ModelLoader.load_name("PARA")
	TextureLoader.set_mat(model, "ITEMS")
	
	$model_root.add_child(model)
	
	# start animation
	$animation_player.play("drop", -1, 0.5)


func _on_animation_player_animation_finished(_anim_name):
	
	# pop from pending items and add to item map 
	get_parent().item_dropping.erase(tile_pos)
	get_parent().item_map[tile_pos] = null
	
	generate_item()
	queue_free()
