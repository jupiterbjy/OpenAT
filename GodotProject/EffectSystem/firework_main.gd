extends GPUParticles2D


var explosion_scene: PackedScene = preload("res://EffectSystem/firework_particle.tscn")


func _process(delta):
	position.y += delta * -200.0


func _on_timer_timeout():
	var explosion: GPUParticles2D = explosion_scene.instantiate()
	get_parent().add_child(explosion)
	explosion.position = position
	queue_free()
