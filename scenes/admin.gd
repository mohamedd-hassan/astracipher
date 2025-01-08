extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var player: Player = $"../Player"
const STAGE_1 = preload("res://dialogue/stage_1.dialogue")

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	print("interacted")
	player.set_physics_process(false)
	player.set_process_input(false)
	player.animated_sprite.play("idle_up")
	DialogueManager.show_dialogue_balloon(STAGE_1, "admin")
	await DialogueManager.dialogue_ended
