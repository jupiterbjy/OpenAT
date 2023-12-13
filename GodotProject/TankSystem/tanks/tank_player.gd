class_name PlayerTank extends BaseTank


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

var _player_idx: int = 1
var _body_texture: String = "TANKPL1"
var _head_type: int


func load_head():
	var model = ModelLoader.load_name(_tank_heads[_head_type])
	model.rotate_y(PI)
	
	TextureLoader.set_mat(model, texture_name)
	
	head_root.add_child(model)


func _attach_upgrade(upgrade_idx, upgrade_level, to: Node3D):
	if upgrade_level == 0:
		return
	
	var model = ModelLoader.load_name(_upgrades[upgrade_idx][upgrade_level - 1])
	model.rotate_y(PI)
	
	TextureLoader.set_mat(model, texture_name)
	
	to.add_child(model)


func load_upgrades():
	
	# process body-attached upgrades
	for upgrade_idx in [UP.MOVE, UP.PROJECTILE]:
		_attach_upgrade(upgrade_idx, upgrades[upgrade_idx], $model_root)
	
	# process head-attached upgrades
	for upgrade_idx in [UP.ARMOR, UP.RELOAD, UP.DAMAGE]:
		_attach_upgrade(upgrade_idx, upgrades[upgrade_idx], head_root)
	
	weapon_type = UserState.selected_weapon_idx
	damage = WorkshopSystem.bullet_damage[weapon_type][upgrades[UP.DAMAGE]]
	reload = WorkshopSystem.bullet_reload[weapon_type][upgrades[UP.RELOAD]]
	projectile_speed = WorkshopSystem.bullet_damage[weapon_type][upgrades[UP.PROJECTILE]]
	base_health = WorkshopSystem.effective_health[upgrades[UP.ARMOR]]
	move_duration = WorkshopSystem.move_duration[upgrades[UP.MOVE]]


func post_ready_setup(_codes: String, facing, start_pos):
	_head_type = UserState.selected_weapon_idx
	upgrades = UserState.upgrades
	texture_name = "PLHEAD"
	
	var model = ModelLoader.load_name("TANKPB")
	model.rotate_y(PI)
	
	model_root.add_child(model)
	
	TextureLoader.set_mat(model, _body_texture)
	
	load_head()
	load_upgrades()
	_post_ready_setup(facing, start_pos)
	
	# TODO: Switch player 1 to inherit from player 2, there's just so many things
	# that should be in player 1 but not in player 2.


func enter_demo_mode():
	print("[PlayerTank] Entering Autonomous mode")
	autonomous = true
	$model_root/head_root.rotation = Vector3(0, 0, 0)
	start()


func exit_demo_mode():
	print("[PlayerTank] Exiting Autonomous mode")
	autonomous = false
	move_subsystem.movement_queue.clear()


func _get_aim_pos():
	var collided = Raycasts.raycast_mouse(Raycasts.aim_mask)
	
	if collided:
		return collided["position"]

	return null


func _on_health_bar_destroyed():
	if _player_idx == 1:
		MapSignals.player_destroyed.emit()
		# UISignals.player_life_lost.emit()
	
	super._on_health_bar_destroyed()


func _on_health_bar_hit():
	if _player_idx == 1:
		UISignals.player_health_ratio_changed.emit(health_bar.health / float(health_bar.health_max))
