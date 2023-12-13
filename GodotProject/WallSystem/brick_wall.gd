extends BaseWall


## Set texture according to it's health
func set_texture():
	if health < 0:
		health = 0
	
	match health:
		4:
			_set_texture_base(_current_wall, "WALLB0")
		3:
			_set_texture_base(_current_wall, "WALLB1")
		2:
			_set_texture_base(_current_wall, "WALLB2")
		1:
			_set_texture_base(_current_wall, "WALLB3")
		0:
			# crash model
			_set_texture_base(_current_wall, "WALLB0")


func parse_heatlh(code: String):
	match code:
		"#", "&":
			health = 4
		"4", "5":
			health = 3
		"2", "7":
			health = 2
		"0", "9":
			health = 1


func setup(code: String, section, parent_pos: Vector2, wall_map: Dictionary):
	wall_type = 1
	parse_heatlh(code)
	super.setup(code, section, parent_pos, wall_map)
