extends Node3D


var _tank_heads: Array[String] = [
	# "TANKPH",
	"ARMGUN",
	"ARMKULEMET",
	"ARMRAKET",
	"ARMELECTRO",
	"ARMFIRE",
	"ARMSHOCK",
]


enum UP {ARMOR, MOVE, RELOAD, PROJECTILE, DAMAGE}
enum WEAPON {CANNON, MINIGUN, ROCKET, ELECTRO, FIRE, SHOCK, SHOCK_SUB}
var _upgrades: Array[Array] = [
	[
		# armor
		"ADDARMOR",
		"ADDARMORII",
		"ADDARMORIII",
		"ADDARMORIIII",
	],
	[
		# movement speed
		"ADDSPM",
		"ADDSPMII",
		"ADDSPMIII",
		"ADDSPMIIII",
	],
	[
		# reload time
		"ADDSPF",
		"ADDSPFII",
		"ADDSPFIII",
		"ADDSPFIIII",
	],
	[
		# projectile speed
		"ADDSPB",
		"ADDSPBII",
		"ADDSPBIII",
		"ADDSPBIIII",
	],
	[
		# damage
		"ADDUN",
		"ADDUNII",
		"ADDUNIII",
		"ADDUNIIII",
	],
]


var _others: Array[Node3D] = []


func load_head():
	var model = ModelLoader.load_name(_tank_heads[UserState.selected_weapon_idx])
	TextureLoader.set_mat(model, "PLHEAD")
	
	_others.append(model)
	add_child(model)


func _attach_upgrade(upgrade_idx, upgrade_level):
	if upgrade_level == 0:
		return
	
	var model = ModelLoader.load_name(_upgrades[upgrade_idx][upgrade_level - 1])
	TextureLoader.set_mat(model, "PLHEAD")
	
	_others.append(model)
	add_child(model)


func load_upgrades():
	for upgrade_idx in [UP.MOVE, UP.PROJECTILE, UP.ARMOR, UP.RELOAD, UP.DAMAGE]:
		_attach_upgrade(upgrade_idx, UserState.upgrades[upgrade_idx])


func load_loadout():
	for obj in _others:
		obj.queue_free()
	
	_others = []
	
	load_upgrades()
	load_head()
	


# Called when the node enters the scene tree for the first time.
func _ready():
	var model = ModelLoader.load_name("TANKPB")
	TextureLoader.set_mat(model, "TANKPL1")
	add_child(model)
	
	load_loadout()
