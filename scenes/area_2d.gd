extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var area_2d: Area2D = $"."
const STAGE_1 = preload("res://dialogue/stage_1.dialogue")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("entered")
	if body is Player:
		DialogueManager.show_dialogue_balloon(STAGE_1, "spotting_npc")


func _on_body_exited(body: Node2D) -> void:
	area_2d.queue_free()
