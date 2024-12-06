extends Node2D

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_dialogic_signal(argument:String):
	if argument == "end":
		print("change")
		get_tree().change_scene_to_file("res://scenes/maze.tscn")
