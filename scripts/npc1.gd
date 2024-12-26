extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: Player = $"../Player"

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	animated_sprite_2d.play("defalut")

func _on_interact():
	print("interacted")
	player.set_physics_process(false)
	player.set_process_input(false)
	player.animated_sprite.play("idle_left")
	if !Dialogic.VAR.talked:
		Dialogic.start("npc1_timeline")
	else:
		Dialogic.start("npc1_timeline2")
	await Dialogic.timeline_ended
