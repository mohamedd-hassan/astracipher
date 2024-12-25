extends Node2D
@onready var npc_3: Area2D = $npc3
@onready var popup_scene=load("res://scenes/popups/popup_control.tscn")
@onready var player: Player = $Player
@onready var sprite_2d_2: AnimatedSprite2D = $npc4/Sprite2D2
@onready var door_l: Door = $Door_L



var avoid_text="you should avoid bullies"
var ignored_text="Good, you should alway ignore bullies"
func create_popups(text_to_show, display_time):
	var new_pop_up = popup_scene.instantiate()
	new_pop_up.position= player.position
	new_pop_up.text_to_show=text_to_show
	new_pop_up.show_time=display_time
	get_tree().current_scene.add_child(new_pop_up)
	

@onready var animated_sprite_2d: AnimatedSprite2D = $npc3/AnimatedSprite2D

func _ready() -> void:
	door_l.hide()
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Dialogic.start("starting")
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _on_dialogic_signal(argument:String):

	if argument == "Ignored1":
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		npc_3.position+=Vector2(1500,10)
		animated_sprite_2d.scale = Vector2(0.033,0.028)
		animated_sprite_2d.play("default") 
		#create_popups(ignored_text,3)
		
	if argument == "talked2":
		npc_3.position=Vector2(-300,-106)	
		
	if argument == "Ignored2":
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		
		#create_popups(ignored_text,3)
		npc_3.position=Vector2(-218,-202)
		animated_sprite_2d.scale = Vector2(0.033,0.028)
		animated_sprite_2d.play("default") 
		
	if argument == "responded1":
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		npc_3.position+=Vector2(1500,10)
		#create_popups(avoid_text,3)
		
	if argument == "responded2":
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		npc_3.position+=Vector2(1500,10)
		#create_popups(avoid_text,3)
	if argument == "wand":
		sprite_2d_2.play("wand")
		await get_tree().create_timer(1).timeout
		sprite_2d_2.play("wand_in")
		door_l.show()
		#sprite_2d_2.play("default")


func _on_level_spawn(destination_tag: String):
	var door_path = "Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
