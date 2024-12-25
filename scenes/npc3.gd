extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea


func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	print("interacted")
	if Dialogic.VAR.timelines==0:
		Dialogic.start("Stage1_bully")
	if Dialogic.VAR.timelines==1:
		Dialogic.start("Stage1_2ndtimebully")
	if Dialogic.VAR.timelines==2:
		Dialogic.start("Stage1_3rdbully")
	await Dialogic.timeline_ended
