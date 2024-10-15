extends Area2D

var speed = 200.0
var has_exploded = false

@onready var sprite = $BulletSprite

func _physics_process(delta):
	if not has_exploded:
		position += Vector2(speed * delta, 0).rotated(rotation)
		sprite.play("normal")

func _on_despawn_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("static_triggers") and not has_exploded:
		speed = 20
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
		#queue_free()

func trigger_explosion():
	has_exploded = true
	sprite.play("explode")
	await get_tree().create_timer(0.3).timeout
	queue_free()
