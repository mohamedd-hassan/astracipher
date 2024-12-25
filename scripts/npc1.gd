extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	animated_sprite_2d.play("defalut")

func _on_interact():
	print("interacted")
	if !Dialogic.VAR.talked:
		Dialogic.start("npc1_timeline")
	else:
		Dialogic.start("npc1_timeline2")
	await Dialogic.timeline_ended
