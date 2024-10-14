extends Label

func _process(delta: float) -> void:
	text = "score: " + str(Global.score)
