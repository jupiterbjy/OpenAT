extends Node


var _tank_scenes: Array[String] = [
	"tank_player2",
	"tank_easy",
	"tank_normal",
	"tank_hard",
	"tank_nuc",
	"tank_rocket",
	"tank_electric",
	"tank_boron",
	"tank_fire",
	"tank_gatling",
	"tank_boss_1",
	"tank_boss_2",
	"tank_boss_3",
]
var _template = "res://TankSystem/tanks/%s.tscn"


var cache: Array[PackedScene] = []


func _ready():
	for tank in _tank_scenes:
		cache.append(load(_template % tank))


func get_tank(idx: int) -> PackedScene:
	return cache[idx]
