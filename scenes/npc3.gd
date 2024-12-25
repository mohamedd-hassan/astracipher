extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("default")


func _on_body_entered(body: Node2D) -> void:
	
	print("interacted")
	if Dialogic.VAR.timelines==0:
		Dialogic.start("Stage1_bully")
	if Dialogic.VAR.timelines==1:
		Dialogic.start("Stage1_2ndtimebully")
	if Dialogic.VAR.timelines==2:
		Dialogic.start("Stage1_3rdbully")
	await Dialogic.timeline_ended
	pass # Replace with function body.
