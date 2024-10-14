extends Area2D

const SPEED = 200.0

var has_exploded = false

@onready var sprite = $BulletSprite

func _physics_process(delta):
	if not has_exploded:
		position += Vector2(SPEED * delta, 0).rotated(rotation)
		sprite.play("normal")

func _on_despawn_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("static_triggers") and not has_exploded:
		trigger_explosion()
		body.trigger_explosion()
		
		# the body.trigger_explosion should be 
		# removed and then it only triggers inside
		# asteroid_script when health==0
		# in the current implementation, its the bullet
		# thats triggering the asteroid explosion
		# asteroid explosion logic to be moved!
		
	if body.has_method("enemy_hit"):
		body.enemy_hit()
		trigger_explosion()
		queue_free()

func trigger_explosion():
	has_exploded = true
	sprite.play("explode")
	await sprite.frame_changed
	queue_free()
