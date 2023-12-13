class_name BaseProjectile extends Area3D


enum WEAPON {CANNON, MINIGUN, ROCKET, ELECTRO, FIRE, SHOCK, SHOCK_SUB}
@export var type: WEAPON


var wall_damage: Array
var damage: float
var _velocity

var _fired_pos: Vector3
var _fired_rotation: Vector3
var _owner_pos: Vector3
var _owner_uuid: int

var _model: Node3D

var is_electric: bool = false

var fire_sound: AudioStream

var is_allie_projectile: bool = false
var counter_group: String = ""

@export var hit_particle: PackedScene
@export var trail_particle: PackedScene
var _trail_particle: GPUParticles3D

@export var lifetime: float = 5.0

@onready var _audio_player: AudioStreamPlayer = $audio_player


enum UP {ARMOR, MOVE, RELOAD, PROJECTILE, DAMAGE}


func _pre_ready_setup(upgrades: Array, is_allie: bool, fired_from: Node3D):
	var _owner: BaseTank = fired_from.get_owner()
	
	if is_allie:
		counter_group = "enemy"
	else:
		counter_group = "allie"

	_fired_pos = fired_from.global_position
	_fired_rotation = fired_from.global_rotation
	
	_owner_pos = _owner.position
	_owner_uuid = _owner.get_instance_id()
	
	# damage = WorkshopSystem.bullet_damage[type][upgrades[UP.DAMAGE]]
	damage = _owner.damage
	
	_velocity = WorkshopSystem.bullet_speed[type][upgrades[UP.PROJECTILE]]
	
	fire_sound = WeaponData.bullet_fire_sounds[type]
	wall_damage = WeaponData.bullet_wall_damage[type]
	
	is_allie_projectile = is_allie
	
	var model_name: String = WeaponData.bullet_models[type]
	if model_name:
		_model = ModelLoader.load_name(model_name)
		_model.rotate_y(PI)
		
		TextureLoader.set_mat(_model, WeaponData.bullet_textures[type])
		add_child(_model)
	
	if trail_particle:
		_trail_particle = trail_particle.instantiate()
		add_child(_trail_particle)
	
	collision_mask = Raycasts.projectile_mask
	collision_layer = Raycasts.layers["Projectile"]


## Abstract method for initialization
func pre_ready_setup(upgrades: Array, is_allie: bool, fired_from: Node3D):
	pass


func damage_wall(body: BaseWall):
	var visited: Dictionary = {}
	
	var queue: Array[BaseWall] = [body]
	
	for damage in wall_damage:
		
		var next_layer_queue: Array[BaseWall] = []
		
		for wall in queue:
			if wall in visited or wall == null:
				continue
			
			visited[wall] = null
			
			wall.damage(damage, is_electric)
			
			next_layer_queue.append_array(wall.adj_tiles)
		
		queue = next_layer_queue


func damage_counter_group(body):
	body.get_damage(damage * 2)


func spawn_action():
	pass


func play_hit_sound(area: Area3D):
	if area.is_in_group("surface_hard"):
		_audio_player.stream = load("res://SoundSystem/Sounds/Dest.wav")
		_audio_player.play()
	
	elif area.is_in_group("tank"):
		_audio_player.stream = load("res://SoundSystem/Sounds/Dest-FT.wav")
		_audio_player.play()
	
	elif area.is_in_group("surface_soft"):
		_audio_player.stream = load("res://SoundSystem/Sounds/Dest-BR.wav")
		_audio_player.play()


func post_hit_action(area: Area3D):
	play_hit_sound(area)
	
	# turn off trail if any
	if _trail_particle:
		_trail_particle.emitting = false
	
	if not hit_particle:
		return
	
	var particle: Node3D = hit_particle.instantiate()
	SceneSignals.current_scene.get_child(0).add_child(particle)
	particle.global_position.x = global_position.x
	particle.global_position.z = global_position.z


enum HIT_TYPE {WALL, STONE_WALL, TANK, FLAG}


func _on_kill_timer_timeout():
	queue_free()


func _ready():
	rotation = _fired_rotation
	global_position = _fired_pos
	
	_audio_player.stream = fire_sound
	_audio_player.play()
	spawn_action()
	$kill_timer.start(lifetime)


func _process(delta):
	position += - _velocity * global_transform.basis.z * delta


func is_hit(area: Area3D) -> bool:
	# check if bullet is already disposed
	if not _velocity:
		return false
	
	if area.is_in_group("tank"):
		if area.get_owner().get_instance_id() == _owner_uuid:
			return false
	
		if area.get_owner().position == _owner_pos:
			return false
	
	# check if it's same team's projectile
	elif area.is_in_group("projectile"):
		if is_allie_projectile == area.is_allie_projectile:
			return false

	elif area.is_in_group("flag"):
		return true

	return true


func _on_area_entered(area):
	
	# skip owner's area, other tanks in same cordinate's area, and already disabled bullet.
	if not is_hit(area):
		return
	
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	
	_velocity = 0
	
	_model.queue_free()
	
	var groups = area.get_groups()
	
	if area.is_in_group("wall"):
		damage_wall(area.get_parent())
	
	elif area.is_in_group(counter_group):
		damage_counter_group(area.get_parent())
	
	# need to destruct this bullet. Run post-hit actions
	post_hit_action(area)
