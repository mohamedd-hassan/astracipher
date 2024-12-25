extends Area2D

@onready var npc: Area2D = $"."
@onready var interaction_area: InteractionArea = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	print("interacted")
	if !Dialogic.VAR.talked_admin and  !Dialogic.VAR.talked_admin_wrong and Dialogic.VAR.talked2:
		Dialogic.start("Stage1_Admin")
	elif  Dialogic.VAR.talked_admin or  Dialogic.VAR.talked_admin_wrong:
		Dialogic.start("admin2nd")
	elif !Dialogic.VAR.talked and !Dialogic.VAR.talked_admin and  !Dialogic.VAR.talked_admin_wrong:
		Dialogic.start("talk_to_2")
	print(Dialogic.VAR.code)
	await Dialogic.timeline_ended
