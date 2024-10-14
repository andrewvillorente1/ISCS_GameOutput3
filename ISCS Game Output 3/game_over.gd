extends CanvasLayer


func _on_retry_pressed():
	Global.playerHealth = 10
	Global.score = 0
	get_tree().change_scene_to_file("res://world.tscn")


func _on_quit_pressed():
	get_tree().quit()
