extends Control


@onready var position_marker = $hbox/bar_root/position_marker

## override this when spawning this ui element
@export var bus_idx: int = 0


static var vol_global_multiplier: float = 0.9
static var vol_low: int = -5
static var vol_high: int = 5
static var vol_step: int = 1

@onready var marker_initial_pos: float = position_marker.position.x

static var marker_pixel_unit = 32
static var marker_low = marker_pixel_unit * -5
static var marker_high = marker_pixel_unit * 5


func _update_visual(cur_vol: int):
	position_marker.position.x = marker_initial_pos + cur_vol * marker_pixel_unit


func _update_vol(amount: int):
	print("[volume_adjust] volume %s" % amount)

	var cur_vol = VolumeManager.get_volume(bus_idx)
	cur_vol = clamp(cur_vol + vol_step * amount, vol_low, vol_high)
	
	_update_visual(cur_vol)
	VolumeManager.set_volume(bus_idx, cur_vol)


# set initial bus volume
func _ready():
	_update_visual(VolumeManager.get_volume(bus_idx))


func _on_left_pressed():
	_update_vol(-1)


func _on_right_pressed():
	_update_vol(1)
