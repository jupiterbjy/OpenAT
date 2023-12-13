extends Sprite2D

var idx: int = 0


func _on_timer_timeout():
	idx = (idx + 1) % 4
	frame = idx
