extends CharacterBody2D

const SPEED = 1.0

var player = null
var canShoot = true

@onready var sprite = $AnimatedSprite2D
@onready var bulletSpawnPosition = $BulletSpawnPosition
var BulletEnemy= preload("res://bullet_enemy.tscn")

func _ready():
	sprite.play("move")

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _physics_process(delta):
	var movement = Vector2(0, SPEED)
	
	if player:
		movement = position.direction_to(player.position) * SPEED
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
