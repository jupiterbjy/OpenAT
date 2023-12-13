extends Control


@onready var player: AnimationPlayer = $player
@onready var bar_sprite: Sprite2D = $HBoxContainer/bar_control/bar


# func set_health_ratio(ratio: float):

	# bar_sprite.region_rect = lerp(_bar_rect[0], _bar_rect[1], ratio)
	# bar_sprite.position.lerp(_bar_pos[0], _bar_pos[1], ratio)
	
	# this might be quite inefficient, but rect2 can't be lerped and this is most simple
	# though, seek & pause just straight up doesn't work, probably due to this being deferred?
	# player.seek(ratio)


func action(ratio: float):
	print("[LifeBarHUD] Setting health ratio to %s" % ratio)
	player.play("health", -1, 0)
	player.seek(ratio)



func _ready():
	# this is super inefficient
	player.play("health", -1, 0)
	player.seek(1.0)
	
	UISignals.player_health_ratio_changed.connect(action)
