class_name BaseEnemeyTank extends BaseTank


static var _tank_models: Array[String] = [
	"",
	"TANKEASY",
	"TANKNORMAL",
	"TANKHARD",
	"TANKNUCLEAN",
	"TANKRAKET",
	"TANKELECTRO",
	"TANKBRON",
	"TANKFIRE",
	"TANKROTGUN",
	"BOSS1",
	"BOSS2",
	"BOSS3",
]

static var _tank_projectiles: Array[String] = [
	"cannon",
	"minigun",
	"rocket",
	"lightning",
	"flamethrower",
	"shock_gun",
]

static var _textures: Array[String] = [
	"TANKENEMY",
	"TANKENEMYRED",
	"TANKENEMYDARK",
	"TANKENEMYBLUE",
	"TANKENEMYINV",
	"TANKENEMYRED",
	"TANKENEMYDARK",
]

static var tank_stats: TankStats = preload(
	"res://TankSystem/base/tank_stat_builder.tscn"
).instantiate()


var _is_hidden = false


func _parse_boss(codes: String) -> TankStats.TYPE:
	var _type: TankStats.TYPE
	
	# only has either 1 among 3 stats
	if "K" in codes:
		texture_name = _textures[6]
		_type = TankStats.TYPE.KB
	
	elif "L" in codes:
		texture_name = _textures[5]
		_type = TankStats.TYPE.LB

	elif "S" in codes:
		texture_name = _textures[5]
		_type = TankStats.TYPE.SB

	score = tank_stats.score[_type]
	base_health = tank_stats.base_health[_type]
	move_duration = tank_stats.move_duration[_type]
	damage = tank_stats.damage[_type]

	return _type


func _parse_arges(codes: String) -> TankStats.TYPE:
	var _type: TankStats.TYPE = int(codes[0])
	
	var multiplier = 1
	
	# only has either 1 among 3 stats
	if "K" in codes:
		texture_name = _textures[2]
		multiplier = 4
	
	elif "L" in codes:
		texture_name = _textures[3]
		multiplier = 3

	elif "S" in codes:
		texture_name = _textures[1]
		multiplier = 2

	score = tank_stats.score[_type] * multiplier
	base_health = tank_stats.base_health[_type] * multiplier
	move_duration = tank_stats.move_duration[_type]
	damage = tank_stats.damage[_type]
	
	# and additional hidden state
	if "I" in codes:
		_is_hidden = true
	
	return _type


func post_ready_setup(codes: String, facing, start_pos):
	var _type: TankStats.TYPE
	
	if "B" in codes:
		# it's boss!
		_type = _parse_boss(codes)
	else:
		_type = _parse_arges(codes)
	
	var diff_multiplier = Difficulty.multiplier[Difficulty.difficulty]
	base_health = int(base_health * (1 / diff_multiplier))
	
	var model = ModelLoader.load_name(_tank_models[_type])
	
	# rotate 180 because it's looking backward
	model.rotate_y(PI)
	$model_root.add_child(model)
	
	TextureLoader.set_mat(model, texture_name)
	
	# TODO: add projectile
	_post_ready_setup(facing, start_pos)


# Called when the node enters the scene tree for the first time.
func _ready():
	if _is_hidden:
		TextureLoader.set_mat($model_root.get_child(0), _textures[4])


func _on_health_bar_hit():
	if _is_hidden:
		_is_hidden = false
		TextureLoader.set_mat($model_root.get_child(1), texture_name)
