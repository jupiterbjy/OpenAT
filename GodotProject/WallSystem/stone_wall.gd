extends BaseWall


## Set texture according to it's health
func set_texture():
	_set_texture_base(_current_wall, "WALLSTONE")


func setup(code: String, section, parent_pos: Vector2, wall_map: Dictionary):
	wall_type = 2
	health = 1
	super.setup(code, section, parent_pos, wall_map)


## Damage action - called by bullet side.
func damage(amount: int, is_electric=false):

	if is_electric:
		on_destroy()
	else:
		set_texture()
