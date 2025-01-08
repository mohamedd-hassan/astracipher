extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../Player"
const STAGE_1 = preload("res://dialogue/stage_1.dialogue")

func _ready() -> void:
	animated_sprite_2d.play("default")


func _on_body_entered(body: Node2D) -> void:
	player.set_physics_process(false)
	player.set_process_input(false)
	
	print("interacted")
	if Global.times_bullied==0:
		DialogueManager.show_dialogue_balloon(STAGE_1, "bully_1")
		player.animated_sprite.play("idle_up")
	elif Global.times_bullied==1:
		DialogueManager.show_dialogue_balloon(STAGE_1, "bully_2")
		player.animated_sprite.play("idle_right")
	elif Global.times_bullied==2:
		player.animated_sprite.play("idle_right")
		DialogueManager.show_dialogue_balloon(STAGE_1, "bully_3")
	await DialogueManager.dialogue_ended
