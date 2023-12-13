extends Node


enum BUS {GLOBAL, MUSIC, UI_SOUND, INGAME_SOUND}


## Global multiplier for preventing way too high db
var multiplier: float = 1.0
var offset = -1


func translate_volume(tick: int) -> float:
	return (tick + 5) / 10.0


## Sets volume to music players. Tick range is -5 ~ 5.
func set_music_volume(tick: int):
	print("[VolumeManager] Setting music bus to %s tick" % tick)
	AudioServer.set_bus_volume_db(BUS.MUSIC, linear_to_db(translate_volume(tick)))


## Sets volume to sound bus. Tick range is -5 ~ 5.
func set_sound_volume(tick: int):
	print("[VolumeManager] Setting sound bus to %s tick" % tick)
	AudioServer.set_bus_volume_db(BUS.UI_SOUND, linear_to_db(translate_volume(tick) * 0.5))
	AudioServer.set_bus_volume_db(BUS.INGAME_SOUND, linear_to_db(translate_volume(tick) * 0.5))


func mute_ingame_sound():
	print("[VolumeManager] Muting ingame sound")
	AudioServer.set_bus_mute(BUS.INGAME_SOUND, true)


func unmute_ingame_sound():
	print("[VolumeManager] Unmuting ingame sound")
	AudioServer.set_bus_mute(BUS.INGAME_SOUND, false)


## update each bus's volume to global state
func update_volume():
	set_music_volume(GlobalState.music_vol)
	set_sound_volume(GlobalState.sound_vol)


## gets volume
func get_volume(bus_enum) -> float:
	match bus_enum:
		BUS.MUSIC:
			return GlobalState.music_vol
		BUS.UI_SOUND:
			return GlobalState.sound_vol
	
	print("[VolumeManager] Unknown Bus ID %s" % bus_enum)
	return 0.0


## sets volume
func set_volume(bus_enum, amount):
	match bus_enum:
		BUS.MUSIC:
			GlobalState.music_vol = amount
		BUS.UI_SOUND:
			GlobalState.sound_vol = amount
	
	update_volume()
	# won't save Globalstate - ui_option will take care of it.


func _ready():
	update_volume()
