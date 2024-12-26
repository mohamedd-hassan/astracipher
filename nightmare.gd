extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("nigtmare")
	
	await Dialogic.timeline_ended
	
	pass # Replace with function body.
func _on_dialogic_signal(argument:String):

	if argument == "nightmare":
		print("signal")
		get_tree().change_scene_to_file("res://scenes/level_one.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
