extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true
	$light.emitting = true


func _on_timer_timeout():
	queue_free()
