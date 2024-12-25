extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
@onready var player: Player = $"../Player"

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	animated_sprite_2d_2.play("idle")
func _on_interact():
	print("interacted")
	player.set_physics_process(false)
	player.set_process_input(false)
	player.animated_sprite.play("idle_left")
	if Dialogic.VAR.talked and !Dialogic.VAR.talked2:
		Dialogic.start("Stage1_NPC2")
	elif Dialogic.VAR.talked2 and Dialogic.VAR.talked:
		Dialogic.start("talknpc2nd")
	else:
		Dialogic.start("talk_to_one")
	await Dialogic.timeline_ended
