extends PathFollow2D

var speed = 0.1


func _process(delta: float) -> void:
	progress_ratio += speed * delta 
