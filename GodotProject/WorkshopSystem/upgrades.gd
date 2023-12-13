extends Node


enum UP {ARMOR, MOVE, RELOAD, PROJECTILE, DAMAGE}
enum WEAPON {CANNON, MINIGUN, ROCKET, ELECTRO, FIRE, SHOCK, SHOCK_SUB}


# no up, up1, up2, ...
var _div = 30.0
var raw_speed: Array[int] = [83, 87, 91, 95, 100]
var move_duration: Array[float] = [
	_div / 83,
	_div / 87,
	_div / 91,
	_div / 95,
	_div / 100,
]


var raw_armor: Array[int] = [0, 10, 20, 30, 40]
var damage_reduction: Array[float] = [0.0, 0.1, 0.2, 0.3, 0.4]
var effective_health: Array[int] = [100, 110, 120, 130, 140]


var bullet_damage: Array[Array] = [
	# no up, up 1~4
	[20, 24, 28, 32, 34],
	[15, 18, 21, 24, 25],
	[8, 9, 11, 12, 13],
	[11, 13, 15, 17, 18],
	[9, 10, 12, 14, 15],
	[15, 18, 21, 24, 25],
	[15, 18, 21, 24, 25],
]


# TODO: Update to actual measured speed
var bullet_speed: Array[Array] = [
	[10, 11, 12, 13, 14],
	[10, 11, 12, 13, 14],
	[8, 9, 10, 1, 12],
	[0, 0, 0, 0, 0],
	[5, 6, 7, 8, 9],
	[8, 9, 10, 1, 12],
	[8, 9, 10, 1, 12],
]


var bullet_reload: Array[Array] = [
	[0.75, 0.65, 0.59, 0.5, 0.43],
	[0.25, 0.21, 0.18, 0.15, 0.12],
	[0.56, 0.5, 0.43, 0.37, 0.31],
	[1.25, 1.12, 1.0, 0.87, 0.75],
	[0.12, 0.09, 0.09, 0.06, 0.06],
	[0.56, 0.5, 0.43, 0.37, 0.31],
]


var upgrade_pricing: Array[Array] = [
	[100, 200, 400, 800],
	[100, 200, 400, 800],
	[100, 200, 400, 800],
	[100, 200, 400, 800],
	[100, 200, 400, 800],
]
