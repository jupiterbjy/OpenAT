extends Node


signal area_selected(area_id: int)
signal level_selected(level_id: int)

signal player_health_ratio_changed(ratio: float)
signal player_life_lost
signal enemy_destroyed
signal player_got_star

signal add_score(amount: int)

signal request_ui(ui_enum, override_enum, border_required: bool)

signal request_overlay(ui_enum)

signal user_selected(idx: int)

# I hate to make this special case but will do temporarily
# might need global UI variabls aside of this later

## player name marked for deletion
var delete_candidate_key: int = 0

## current active ui's enum
var current_ui_enum = UIEnum.SPLASH
