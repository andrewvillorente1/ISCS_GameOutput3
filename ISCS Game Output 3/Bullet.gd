extends Area2D

const SPEED = 200.0
@onready var sprite = $BulletSprite

func _physics_process(delta):
	position += Vector2(SPEED * delta, 0).rotated(rotation)
	
	sprite.play("normal")

func _on_body_entered(body):
	if body.is_in_group("static_triggers"):
		body.trigger_explosion()
		sprite.play("explode")  
		queue_free()  
