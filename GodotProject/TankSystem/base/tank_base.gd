class_name BaseTank
extends Node3D


## Tank type
enum TYPE {ALLIE, ENEMY, BOSS}
@export var tank_type: TYPE

@export var weapon_type: WorkshopSystem.WEAPON

@export var damage: int = 20

@export var score: int = 0

@export var move_duration: float = 1.2

@export var projectile_speed: float = 10.0

@export var reload: float = 4.0

@export var base_health: int = 100

@export var upgrades: Array = [0, 0, 0, 0, 0]

@export var autonomous: bool = true

@onready var move_subsystem: MovementSubsystem = $movement_subsystem

# Apparently type-hinting this breaks all BaseProjectile subclasses!
@onready var weapon_subsystem = $weapon_subsystem
@onready var item_subsystem: ItemSubsystem = $item_subsystem

@onready var model_root = $model_root
@onready var head_root = $model_root/head_root

@onready var health_bar: HealthBar = $health_bar

var is_item_drop: bool = false

var texture_name: String = "TANKENEMY"
var code: String = ""


## override this setup on child classes
func post_ready_setup(_codes: String, _facing, _start_pos):
	pass


func _post_ready_setup(
	facing,
	start_pos: Vector2,
):
	# move pos & record entry on dictionary
	position = Vector3(start_pos.x, 0, start_pos.y)
	
	if tank_type == TYPE.ALLIE:
		MapSignals.tank_spawned.emit(1, start_pos)
		$hitbox.collision_layer = $hitbox.collision_layer | Raycasts.layers["Allie"]
	else:
		MapSignals.tank_spawned.emit(0, start_pos)
		$hitbox.collision_layer = $hitbox.collision_layer | Raycasts.layers["Enemy"]

	# rotate mesh itself
	model_root.rotate_y(facing * PI / 2)
	# head_root.rotate_y(facing * PI / 2)

	# setup animations if any exists
	model_root.setup()
	
	move_subsystem.post_ready_setup(facing, tank_type)
	
	weapon_subsystem.post_ready_setup(weapon_type, tank_type)
	
	health_bar.setup(base_health)
	
	item_subsystem.post_ready_setup(is_item_drop)


func start():
	if autonomous:
		move_subsystem.start()
		weapon_subsystem.start()


func get_damage(amount: int):
	health_bar.get_damage(amount - amount * WorkshopSystem.damage_reduction[upgrades[0]])


func _on_health_bar_destroyed():
	MapSignals.tank_destroyed.emit(int(tank_type == TYPE.ALLIE), move_subsystem.current_pos, score)
	
	# init destruction effect
	var effect: Node3D = load("res://EffectSystem/tank_explosion.tscn").instantiate()
	effect.setup(texture_name)
	get_parent().add_child(effect)
	effect.global_position = global_position
	
	# request drop if eligible
	if is_item_drop:
		item_subsystem.request_drop()
	
	# init destruction mark
	MapSignals.spawn_trail.emit(Vector2(position.x, position.z), 2, randi_range(0, 3))
	
	queue_free()
