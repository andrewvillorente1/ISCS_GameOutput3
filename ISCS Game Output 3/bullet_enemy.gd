extends Area2D

var speed = 100.0
var has_exploded = false
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	position.y += delta * speed

func _on_despawn_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("player_hit") and not has_exploded:
		speed = 10
		trigger_explosion()
		body.player_hit()

func trigger_explosion():
	has_exploded = true
	sprite.play("explode")
	await get_tree().create_timer(0.2).timeout
	queue_free()
