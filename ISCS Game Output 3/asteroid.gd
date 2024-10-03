extends StaticBody2D

@onready var sprite = $AsteroidSprite

func _ready():
	sprite.play("normal")
	add_to_group("static_triggers")
func trigger_explosion():
	sprite.play("asteroid_explode")
	await get_tree().create_timer(0.5).timeout
	queue_free()  
