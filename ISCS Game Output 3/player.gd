extends CharacterBody2D

const SPEED = 80.0
const ACCELERATION = 400.0
const DECELERATION = 200.0
const FRICTION = 100.0
const ROTATION_SPEED = 20.0

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input_direction = Vector2(
		Input.get_axis("ui_left", "ui_right"), 
		Input.get_axis("ui_up", "ui_down")
	)

	if input_direction != Vector2.ZERO:
		input_direction = input_direction.normalized()
		velocity = velocity.move_toward(input_direction * SPEED, ACCELERATION * delta)
		var target_rotation = input_direction.angle() + deg_to_rad(90)
		sprite.rotation = lerp_angle(sprite.rotation, target_rotation, ROTATION_SPEED * delta)
		sprite.play("move")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
		sprite.play("idle")

	move_and_slide()
