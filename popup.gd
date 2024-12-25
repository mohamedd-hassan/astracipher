extends Control

var text_to_show="This pop up"
var show_time=3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$panel/Label.text=text_to_show
	$Timer.start(show_time)
	

func _on_timer_timeout() -> void:
	queue_free()
