extends Node2D

@onready var node_2d: Node2D = $"."
@onready var point_light_2d_2: PointLight2D = $Player/PointLight2D2
const KNOWLEDGE_VARIATION = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	
	point_light_2d_2.texture_scale = Dialogic.VAR.Knowledge
