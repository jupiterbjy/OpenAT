extends PlayerTank


func load_upgrades():
	
	# process body-attached upgrades
	for upgrade_idx in [UP.MOVE, UP.PROJECTILE]:
		_attach_upgrade(upgrade_idx, upgrades[upgrade_idx], $model_root)
	
	# process head-attached upgrades
	for upgrade_idx in [UP.ARMOR, UP.RELOAD, UP.DAMAGE]:
		_attach_upgrade(upgrade_idx, upgrades[upgrade_idx], head_root)
	
	damage = WorkshopSystem.bullet_damage[weapon_type][upgrades[UP.DAMAGE]]
	reload = WorkshopSystem.bullet_reload[weapon_type][upgrades[UP.RELOAD]]
	projectile_speed = WorkshopSystem.bullet_damage[weapon_type][upgrades[UP.PROJECTILE]]
	base_health = WorkshopSystem.effective_health[upgrades[UP.ARMOR]]
	move_duration = WorkshopSystem.move_duration[upgrades[UP.MOVE]]


func post_ready_setup(_codes: String, facing, start_pos):
	_player_idx = 2
	for idx in range(5):
		upgrades[idx] = randi_range(0, 4)
	
	# fire and shock is incomplete, limit range
	weapon_type = randi_range(0, len(WEAPON) - 4)
	
	_head_type = weapon_type
	
	texture_name = "PL2HEAD"
	_body_texture = "TANKPL2"
	
	var model = ModelLoader.load_name("TANKPB")
	model.rotate_y(PI)
	
	model_root.add_child(model)
	
	TextureLoader.set_mat(model, _body_texture)
	
	load_head()
	load_upgrades()
	
	# TODO: add projectile
	_post_ready_setup(facing, start_pos)
