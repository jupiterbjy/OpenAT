extends Node


func show_gizmo():
	print("[DebugManager] Showing gizmos")
	get_tree().call_group("debug_gizmos", "show")

func hide_gizmo():
	print("[DebugManager] Hiding gizmos")
	get_tree().call_group("debug_gizmos", "hide")


func _ready():
	hide_gizmo()


var enabled: bool = false
var is_fullscreen: bool = false


func toggle_fullscreen():
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	is_fullscreen = not is_fullscreen


func _unhandled_input(event):
	if event.get_action_strength("toggle_debug"):
		if enabled:
			hide_gizmo()
		else:
			show_gizmo()
		
		enabled = not enabled
	
	elif event.is_action_pressed("add_money"):
		print("[DebugManager] Adding 100 money")
		UserState.money += 100
	
	elif event.is_action_pressed("remove_money"):
		print("[DebugManager] Removing 100 money")
		UserState.money = max(UserState.money - 100, 0)


func _input(event):
	if event.is_action_pressed("fullscreen_toggle"):
		print("[DebugManager] Toggling Fullscreen")
		toggle_fullscreen()
