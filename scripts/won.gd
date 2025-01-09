extends Node2D

@onready var typing: AudioStreamPlayer2D = $typing
@onready var main_animation: AnimationPlayer = $main_animation
var visible_characters = 0

func _ready() -> void:
	main_animation.play("typing")

func _process(delta: float) -> void:
	if visible_characters != $RichTextLabel.visible_characters:
		visible_characters = $RichTextLabel.visible_characters
		typing.play()

func transition():
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://CREDITS/GodotCredits.tscn")
