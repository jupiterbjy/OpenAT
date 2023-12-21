extends Node


signal game_start(area_id: int, level_id: int)
signal game_pause
signal game_unpause

signal game_over
signal game_victory

signal game_score_checked

signal item_taken(item: BaseItem)

signal tank_spawned(is_allie: bool, pos: Vector2)
signal tank_moved(is_allie: bool, start: Vector2, end: Vector2)
signal tank_destroyed(is_allie: bool, pos: Vector2, score: int)

signal player_spawned(player: PlayerTank)
signal player_destroyed

signal wall_cluster_destroyed(cluster: BaseWallCluster, is_target: bool)
signal wall_cluster_regened(cluster: BaseWallCluster, is_target: bool)

signal spawn_trail(pos: Vector2, action, facing)

signal update_player_loadout
signal enter_demo


signal hide_cursor
signal show_cursor


func on_start(area_id: int, level_id: int):
	MapJsonLoader.load_level_data(area_id, level_id)


func pause_game():
	get_tree().paused = true


func unpause_game():
	get_tree().paused = false


func _ready():
	game_start.connect(on_start)
	game_pause.connect(pause_game)
	game_unpause.connect(unpause_game)
