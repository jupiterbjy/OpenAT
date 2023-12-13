class_name BaseItem
extends Node3D


@onready var _turntable: Node3D = $turn_table

@export var item_code = ""
@export var default_light_model = "ITEMLIGHT"
@export var default_light_texture = "ITEMLIGHT"

@export var rotate_speed = 2.0
@export var score = 10

static var model_cache: Dictionary = {}
static var model_resources: Dictionary = {
	# Code(if one letter only): [MODEL_NAME, MODEL_TEXTURE_NAME, ]
	
	# falling box
	"DROP": ["PARA", "ITEMS"],
	
	# box event obj
	"BOX": ["EVHOST", "ITEMS"],
	
	# opening box
	"OPENING_BOX": ["BOX", "ITEMS"],
	
	"C": ["CLOCK", "ITEMS"],
	"S": ["SHIELD", "ITEMS"], # add SHIELD effect 
	"M": ["MEDIC", "ITEMS"],
	"L": ["LOPATA", "ITEMS"], # Shovel
	"Z": ["ZAMOK", "ITEMS"], # Lock
	"R": ["AMMO", "ITEMS"],
	"B": ["BOMB", "ITEMS"], # uses BOXLIGHT
	"I": ["MINA", "ITEMSSC"], # OBJMINA for ground placement
	"X": ["STAR", "ITEMS"],
	
	"MONEY": ["SCKEY", "ITEMSSC"], # uses SCOREEFFECT as bg
}


func _ready():
	# prevent pausing, this need to rotate
	process_mode = PROCESS_MODE_ALWAYS
	
	# load item shine effect
	if default_light_model:
		var light: Node3D = ModelLoader.load_name(default_light_model)
		TextureLoader.set_mat(light, default_light_model)
		_turntable.add_child(light)
	
	# load model
	var arr: Array = model_resources[item_code]
	var model: Node3D = ModelLoader.load_name(arr[0])
	
	TextureLoader.set_mat(model, arr[1])
	_turntable.add_child(model)


func _process(delta):
	_turntable.rotate_y(delta * rotate_speed)


func _on_area_area_entered(area: Area3D):
	print("[ItemBase] Item %s collided" % item_code)
	
	# run action and queue for removal
	if action(area):
		MapSignals.item_taken.emit(self)
		$area.queue_free()
		
		for child in $turn_table.get_children():
			child.queue_free()
		
		$pickup_sound.play()


## Action when item is collided
func action(area: Area3D) -> bool:
	print("[ItemBase] Unimplemented item action, please implement")
	return false


func _on_pickup_sound_finished():
	queue_free()
