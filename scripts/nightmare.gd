extends Node2D
@onready var text_display: AnimationPlayer = $text_display

func _ready() -> void:
	text_display.play("skibidi")

func transition():
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/level_one.tscn")
