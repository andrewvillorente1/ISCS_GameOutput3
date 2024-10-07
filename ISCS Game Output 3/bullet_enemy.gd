extends Area2D

const SPEED = 100.0

func _physics_process(delta):
	position.y += delta * SPEED
