class_name ItemSubsystem extends Node3D

var _stars: int = 0
var _star_heal_amount: int = 10

var shield_model: Node3D

# signal for killing all enemy tanks.
signal trigger_bomb

# can't use @onready as these has to run post-ready time
@onready var turntable: Node3D = $ring_turntable
@onready var flip_timer: Timer = $ring_flip_timer


func _ready():
	# need to reset lock state when game's over
	
	for signal_: Signal in [MapSignals.game_over, MapSignals.game_victory, MapSignals.game_start]:
		signal_.connect(_on_the_world_timer_timeout)
		signal_.connect(_on_lockdown_timer_timeout)


func request_drop():
	ItemSignals.drop_requested.emit()


func spawn_item_ring():
	var model = ModelLoader.load_name("METKA")
	TextureLoader.set_mat(model, "EFFECTS")
	
	turntable.add_child(model)
	flip_timer.start(0.1)


func on_triger_bomb():
	var parent = get_parent()
	
	if parent.tank_type == parent.TYPE.ALLIE:
		return
	
	# add bomb effect
	var eff = load("res://EffectSystem/bomb_effect.tscn").instantiate()
	add_child(eff)


func set_lockdown():
	get_parent().weapon_subsystem.is_locked = true
	$lockdown_timer.start(5)


func add_star():
	if _stars < 3:
		_stars += 1
	
	_on_star_heal_timer_timeout()
	$star_heal_timer.start(10)


func set_invincible():
	get_parent().health_bar.is_invincible = true
	$invincibility_timer.start(10)
	
	if not shield_model:
		shield_model = load("res://EffectSystem/shield_effect.tscn").instantiate()
		add_child(shield_model)


func set_the_world():
	get_parent().move_subsystem.is_the_world = true
	$the_world_timer.start(10)


var normal_reload: float

func set_rapid_fire():
	get_parent().reload /= 2.0
	$fire_rate_timer.start(10)


func post_ready_setup(is_item_drop: bool):
	normal_reload = get_parent().reload
	
	if is_item_drop:
		spawn_item_ring()


func _on_lockdown_timer_timeout():
	get_parent().weapon_subsystem.is_locked = false


func _on_the_world_timer_timeout():
	get_parent().move_subsystem.is_the_world = false


func _on_invincibility_timer_timeout():
	get_parent().health_bar.is_invincible = false
	
	if shield_model:
		shield_model.queue_free()


func _on_fire_rate_timer_timeout():
	get_parent().reload = normal_reload


func _on_star_heal_timer_timeout():
	get_parent().health_bar.get_damage(-_stars * _star_heal_amount)
	UISignals.player_health_ratio_changed.emit(get_parent().health_bar.get_ratio())


func _on_ring_flip_timer_timeout():
	turntable.rotate_y(20.0 * 180 / PI)
