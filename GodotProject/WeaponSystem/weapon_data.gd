extends Node


enum TYPE {CANNON, MINIGUN, ROCKET, ELECTRO, FIRE, SHOCK, SHOCK_SUB}


var bullet_fire_sounds: Array[AudioStream] = [
	preload("res://SoundSystem/Sounds/Fire.wav"),
	preload("res://SoundSystem/Sounds/A_otcannon.wav"),
	preload("res://SoundSystem/Sounds/an_misslaun.wav"),
	preload("res://SoundSystem/Sounds/an_light-3.wav"),
	preload("res://SoundSystem/Sounds/an_fire.wav"),
	preload("res://SoundSystem/Sounds/an_shock.wav"),
]


var bullet_models: Array[String] = [
	"BULLET1",
	"BULLET1",
	"BULLETRAKETA",
	"",
	"BULLETFIRE",
	"BULLETSHOCK",
	"BULLETSHSC",
]


var bullet_textures: Array[String] = [
	"BULLET",
	"BULLET",
	"PLHEAD",
	"",
	"FIRE",
	"BULLET",
	"BULLET",
]


var bullet_names: Array[String] = [
	"Cannon",
	"Minigun",
	"Rocket",
	"Lightning",
	"Flamethrower",
	"Shock Gun",
	"",
]


var bullet_wall_damage: Array[Array] = [
	# [direct hit damage, 1st adj. tile damage, 2nd... ]
	[2],
	[1],
	[2, 1, 1], # 1 as splash
	[4, 2], # 2 as splash,
	[1, 1],
	[1, 1],
	[1],
]


var entries: Array[PackedScene] = [
	load("res://WeaponSystem/Projectiles/cannon.tscn"),
	load("res://WeaponSystem/Projectiles/gatling.tscn"),
	load("res://WeaponSystem/Projectiles/rocket.tscn"),
	load("res://WeaponSystem/Projectiles/electro.tscn"),
	load("res://WeaponSystem/Projectiles/fire.tscn"),
	load("res://WeaponSystem/Projectiles/shock.tscn"),
	load("res://WeaponSystem/Projectiles/shock_sub.tscn"),
]
