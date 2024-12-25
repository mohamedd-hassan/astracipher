extends Node2D
@onready var npc_3: Area2D = $npc3
@onready var popup_scene=load("res://scenes/popups/popup_control.tscn")
@onready var player: Player = $Player



var avoid_text="you should avoid bullies"
var ignored_text="Good, you should alway ignore bullies"
func create_popups(text_to_show, display_time):
	var new_pop_up = popup_scene.instantiate()
	new_pop_up.position= player.position
	new_pop_up.text_to_show=text_to_show
	new_pop_up.show_time=display_time
	get_tree().current_scene.add_child(new_pop_up)
	


func _ready() -> void:
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _on_dialogic_signal(argument:String):

	if argument == "Ignored1":
		npc_3.position+=Vector2(150,10)
		create_popups(ignored_text,3)
	if argument == "Ignored2":
		create_popups(ignored_text,10)
		npc_3.position+=Vector2(150,3)
	if argument == "responded1":
		npc_3.position+=Vector2(1500,10)
		create_popups(avoid_text,3)
	if argument == "responded2":
		npc_3.position+=Vector2(1500,10)
		create_popups(avoid_text,3)


func _on_level_spawn(destination_tag: String):
	var door_path = "Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
