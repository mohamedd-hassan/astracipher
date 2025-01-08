extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../Player"
const STAGE_1 = preload("res://dialogue/stage_1.dialogue")

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	animated_sprite_2d.play("defalut")

func _on_interact():
	print("interacted")
	player.set_physics_process(false)
	player.set_process_input(false)
	player.animated_sprite.play("idle_left")
	DialogueManager.show_dialogue_balloon(STAGE_1, "npc1")
	await DialogueManager.dialogue_ended
