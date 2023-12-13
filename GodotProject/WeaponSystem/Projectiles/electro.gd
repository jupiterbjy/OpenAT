extends BaseProjectile


@onready var secondary_area: Area3D = $secondary_area
@onready var secondary_area_shape: CollisionShape3D = $secondary_area/CollisionShape
var _fired_obj: Node3D


# no sound to play
func play_hit_sound(area: Area3D):
	pass


func pre_ready_setup(upgrades: Array, is_allie: bool, fired_from: Node3D):
	_fired_obj = fired_from
	
	_pre_ready_setup(upgrades, is_allie, fired_from)
	is_electric = true
	damage *= 3


func spawn_action():
	var results = Raycasts.get_length(_fired_obj, Raycasts.elect_length_mask, 8)
	var obj = results[0]
	var length = clamp(results[1], 0, 8)

	# load corresponding length
	$elect_model_root.determine_length_idx(length)
	
	# set collider
	secondary_area_shape.shape.size.z = length
	secondary_area_shape.position.z = -length / 2
	
	$secondary_area/electro_gizmo.mesh.size.z = length
	$secondary_area/electro_gizmo.position.z = -length / 2
	
	$disable_timer.start(0.1)
	
	secondary_area.monitorable = true
	secondary_area.monitoring = true
	
	if obj and obj.is_in_group("wall"):
		damage_wall(obj.get_parent())


func _on_area_entered(area: Area3D):
	set_deferred("monitoring", false)
	post_hit_action(area)
	$disable_timer.start(0.1)


func _on_elect_model_root_animation_done():
	# quite messy, but I aint got any time right now. I'm very ill!
	# wait until effect is fully wore off
	
	secondary_area.monitorable = false
	secondary_area.monitoring = false
	$wait_effect_timer.start(1.0)


# override projectile movement
func _process(_delta):
	pass


func _on_secondary_area_area_entered(area):
	if area.is_in_group(counter_group):
		damage_counter_group(area.get_parent())
	
	_on_area_entered(area)


func _on_disable_timer_timeout():
	secondary_area.monitoring = false


func _on_wait_effect_timer_timeout():
	queue_free()
