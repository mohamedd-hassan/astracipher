extends AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $PointLight2D/AnimationPlayer
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var lantern: AnimatedSprite2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animation_player.play("flicker")
