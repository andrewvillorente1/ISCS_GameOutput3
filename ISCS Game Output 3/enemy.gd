extends CharacterBody2D

const SPEED = 0.8

var health = 3
var player = null
var canShoot = true
var BulletEnemy= preload("res://bullet_enemy.tscn")

@onready var sprite = $AnimatedSprite2D
@onready var bulletSpawnPosition = $BulletSpawnPosition
#@onready var collision_shape = $CollisionShape2D


func _ready():
	sprite.play("move")
	#collision_shape.disabled = true

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		#collision_shape.disabled = false

func _physics_process(delta):
	var movement = Vector2(0, SPEED)
	
	if player:
		movement = position.direction_to(player.position) * SPEED
		movement.y = SPEED # lock vertical movement to move down
	movement = move_and_collide(movement)

func _on_bullet_fire_rate_timeout() -> void:
	canShoot = true
	if player != null:
		shoot()

func shoot():
	if canShoot:
		var bullet = BulletEnemy.instantiate()
		bullet.position = bulletSpawnPosition.global_position
		get_parent().add_child(bullet)
		
		$BulletFireRate.start()
		canShoot = false

func enemy_hit():
	health -= 1
	if health == 0:
		Global.score += 100 * Global.playerHealth
		sprite.play("explode")
		await get_tree().create_timer(0.25).timeout
		queue_free()
