extends Node

class_name Stopwatch

@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var progress_bar: TextureProgressBar = $TextureProgressBar

func _process(delta: float) -> void:
	label.text = time_to_string()
	progress_bar.value = (timer.time_left / 300) * 100

	
func time_to_string() -> String:
	var time_left = timer.time_left
	var msec = fmod(time_left, 1) * 100
	var sec = int(time_left) % 60
	var min = floor(time_left / 60)
	var format_string = "%02d:%02d:%02d"
	var actual_string = format_string % [min, sec, msec]
	return actual_string
