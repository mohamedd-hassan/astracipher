extends Node2D

@onready var point_light: PointLight2D = $Player/PointLight2D
@onready var animation_player: AnimationPlayer = $Player/PointLight2D/AnimationPlayer

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	#point_light.texture_scale = Dialogic.VAR.Knowledge
	animation_player.play("flicker")
