class_name UIManager
extends Control


@onready var border: Control = $border


# maybe caching is better, maybe not, not sure at this point
## Relative path array of each UI
var _uis: Array[String] = [
	# "fullscreen/ui_loading",
	"fullscreen/ui_splash",
	"ui_main_menu",
	"ui_options",
	"ui_highscore",
	"ui_credits",
	"ui_quit_game",
	"ui_new_user",
	"ui_player_select",
	"ui_stage_editor",
	"ui_map_select",
	"ingame/ui_briefing",
	"ingame/ui_workshop",
	"ingame/ui_workshop_confirm",
	"ingame/ui_hud",
	"ingame/ui_pause",
	"ingame/ui_objectives",
	"ingame/ui_score",
	"fullscreen/ui_ending",
	"ui_delete_confirm",
	"ui_name_taken",
	"ingame/ui_dialogue_allie",
	"ingame/ui_dialogue_win",
	"ingame/ui_dialogue_lose",
	"ingame/ui_dialogue_lose",
	"ingame/ui_game_over",
	"ingame/ui_tutorial",
]

var _ui_state: Dictionary = {
	"health_rate": 1.0,
	"star_count": 0,
	"enemy_count": 0,
	"score": 0,
}

var _ui_packed_cache: Dictionary = {}

## UI path template
var _template_path: String = "res://UI/UI Scenes/%s.tscn"

## Current UI enum
var _current_ui: Control = null


## Loads UI. If overrride_enum is set to one of UIEnum, will set destination UI
## to such for Settings & Workshop UI. This must define var 'switching_target'.
func load_ui(ui_enum, override_enum=null, require_border=true):
	# even if same ui is open we'll drop it
	
	# drop previous
	if _current_ui:
		_current_ui.queue_free()
	
	if require_border:
		border.show()
	else:
		border.hide()

	UISignals.current_ui_enum = ui_enum
	print("[UIManager] Switching to %s" % _uis[ui_enum])

	# check cache, if missing load one
	if ui_enum not in _ui_packed_cache:
		_ui_packed_cache[ui_enum] = load(_template_path % _uis[ui_enum])

	_current_ui = _ui_packed_cache[ui_enum].instantiate()
	
	# set override if required
	if override_enum:
		_current_ui.switching_target = override_enum
	
	add_child.call_deferred(_current_ui)


func add_overlay(ui_enum):
	# UISignals.current_ui_enum = ui_enum
	print("[UIManager] Adding overlay %s" % _uis[ui_enum])

	# check cache, if missing load one
	if ui_enum not in _ui_packed_cache:
		_ui_packed_cache[ui_enum] = load(_template_path % _uis[ui_enum])

	add_child.call_deferred(_ui_packed_cache[ui_enum].instantiate())


func _ready():
	UISignals.request_ui.connect(load_ui)
	UISignals.request_overlay.connect(add_overlay)
	load_ui(UIEnum.SPLASH)


func _unhandled_key_input(event):
	if event.is_action_pressed("hide_ui"):
		_current_ui.visible = not _current_ui.visible
