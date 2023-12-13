extends Node


var score_tank: int = 0
var score_item: int = 0


func on_enemy_destroy(is_allie: bool, _pos, score: int):
	if is_allie:
		return
	
	score_tank += score
	
	UISignals.add_score.emit(score)


func on_item_take(item_obj: BaseItem):
	score_item += item_obj.score
	
	UISignals.add_score.emit(item_obj.score)


func reset_score():
	score_tank = 0
	score_item = 0


func _ready():
	MapSignals.tank_destroyed.connect(on_enemy_destroy)
	MapSignals.item_taken.connect(on_item_take)
