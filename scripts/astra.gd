extends CharacterBody2D
@onready var interaction_area: Area2D = $InteractionArea
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D2

var start_interaction = false

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if !start_interaction:
		animated_sprite.play("idle_down")
		
func _on_interaction_area_body_entered(body: Node2D) -> void:
	start_interaction = true
	print("entered astra (ew)")
	animated_sprite.play("up")
