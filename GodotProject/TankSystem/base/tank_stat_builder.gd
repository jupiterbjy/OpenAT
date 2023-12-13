class_name TankStats extends Node


enum TYPE {ALLIE, EASY, NORMAL, HARD, NUKE, ROCKET, ELECT, BORON, FIRE, GATLING, SB, LB, KB}
enum CODE {NONE, S, L, K}


var base_health: Array[int] = [
	100, 20, 30, 40, 40, 50, 30, 30, 40, 40, 1500, 2000, 1000
]


var score: Array[int] = [
	-1, 2, 3, 4, 4, 3, 8, 3, 8, 8, 100, 200, 400
]

var damage: Array[int] = [
	0,
	base_health[TYPE.ALLIE] * 0.25,
	base_health[TYPE.ALLIE] * 0.25,
	base_health[TYPE.ALLIE] * 0.25,
	
	# nuke
	base_health[TYPE.ALLIE] * 0.25,
	
	# rocket
	base_health[TYPE.ALLIE] * 0.4,
	
	# elect
	base_health[TYPE.ALLIE] * 0.8,
	
	# boron
	base_health[TYPE.ALLIE] * 0.25,
	
	# fire - additional same burn damage after 0.2 sec
	base_health[TYPE.ALLIE] * 0.17,
	
	# gatling
	base_health[TYPE.ALLIE] * 0.2,
	
	# SB
	base_health[TYPE.ALLIE] * 0.3,
	
	# LB - burn damage after 0.2 sec
	base_health[TYPE.ALLIE] * 0.13,
	
	# KB
	base_health[TYPE.ALLIE] * 0.3,
]


# score & health multiplier. doesn't work with boss and allie
var multiplier: Array[int] = [1, 2, 3, 4]


var move_duration: Array[float] = [
	0.5,
	0.4,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	1.0,
	0.5,
	0.5,
	0.8,
	0.5,
	0.3,
]
