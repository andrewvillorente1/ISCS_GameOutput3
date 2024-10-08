extends Node2D

var Enemy = preload("res://enemy.tscn")

func _on_spawn_timer_timeout() -> void:
	var enemy = Enemy.instantiate()
	enemy.position = Vector2(randi_range(-180, 180), -148)
	add_child(enemy)
