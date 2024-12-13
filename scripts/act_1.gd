extends Node2D
@onready var npc_3: Area2D = $npc3




func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _on_dialogic_signal(argument:String):

	if argument == "Ignored1":
		npc_3.position+=Vector2(150,10)
	if argument == "Ignored2":
		npc_3.position+=Vector2(150,10)
	if argument == "responded1":
		npc_3.position+=Vector2(1500,10)
	if argument == "responded2":
		npc_3.position+=Vector2(1500,10)


func _on_level_spawn(destination_tag: String):
	var door_path = "Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
