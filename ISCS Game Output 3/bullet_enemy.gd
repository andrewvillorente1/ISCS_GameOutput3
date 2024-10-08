extends Area2D

const SPEED = 100.0

func _physics_process(delta):
	position.y += delta * SPEED

func _on_despawn_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player_hit"):
		body.player_hit()
		queue_free()
