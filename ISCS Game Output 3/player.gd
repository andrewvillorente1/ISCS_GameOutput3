extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION = 400.0
const DECELERATION = 200.0
const FRICTION = 100.0
const ROTATION_SPEED = 20.0

#var health = 10 # player health is now a Global variable
var bullet_scene = preload("res://bullet.tscn")

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	var input_direction = Vector2(
		Input.get_axis("ui_left", "ui_right"), 
		Input.get_axis("ui_up", "ui_down")
	)

	if input_direction != Vector2.ZERO:
		input_direction = input_direction.normalized()
		velocity = velocity.move_toward(input_direction * SPEED, ACCELERATION * delta)
		#var target_rotation = input_direction.angle() + deg_to_rad(90)
		#sprite.rotation = lerp_angle(sprite.rotation, target_rotation, ROTATION_SPEED * delta)
		sprite.play("move")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
		sprite.play("idle")
	
	move_and_slide()
	
	if(Global.playerHealth <= 0):
		sprite.play("explode")
	
	if Input.is_action_just_pressed("ui_accept"):
		_spawn_bullet()

func _spawn_bullet():
	var bullet = bullet_scene.instantiate()
	var offset = Vector2(0, -8).rotated(sprite.rotation) 
	bullet.name = "Bullet"
	bullet.position = position + offset 
	bullet.rotation = sprite.rotation - deg_to_rad(90)
	get_parent().add_child(bullet)

func player_hit():
	Global.playerHealth -= 1
	if Global.playerHealth == 0:
		await get_tree().create_timer(0.4).timeout
		get_tree().change_scene_to_file("res://game_over.tscn")
		
