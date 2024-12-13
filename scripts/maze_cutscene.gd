extends Node2D

@onready var point_light: PointLight2D = $Player/PointLight2D
@onready var animation_player: AnimationPlayer = $Player/PointLight2D/AnimationPlayer

func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("cutscene_timeline")
	await Dialogic.timeline_ended

func _on_dialogic_signal(argument:String):
	if argument == "end":
		print("change")
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scenes/maze.tscn")

func _process(delta: float) -> void:
	#point_light.texture_scale = Dialogic.VAR.Knowledge
	animation_player.play("flicker")
