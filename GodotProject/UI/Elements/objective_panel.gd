class_name ObjectivePanel
extends Control


static var objective_scene: PackedScene = load("res://UI/Elements/objective.tscn")

enum {BOX, BUNKER, ENEMY, BASE}


func _add_objective(type_id):
	var container: VBoxContainer = $container
	
	var new_obj = objective_scene.instantiate()
	
	new_obj.set_type(type_id)
	container.add_child.call_deferred(new_obj)


func add_objectives(objective_str: String):
	print("[ObjectivePanel] Got objective " + objective_str)

	for ch in objective_str:
		match ch:
			"B":
				_add_objective(ENEMY)
			"F":
				_add_objective(BASE)
			"H":
				_add_objective(BOX)
			"T":
				_add_objective(BUNKER)
			var code:
				print("[ObjectivePanel] Unknown code " + code)


func _ready():
	# drop all objectives, it's for UI design only
	for child in $container.get_children():
		child.queue_free()
	
	add_objectives(MapJsonLoader.current_loaded["game_type"])
