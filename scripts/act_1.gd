extends Node2D

@onready var npc_3: Area2D = $npc3
@onready var popup_scene=load("res://scenes/popups/popup_control.tscn")
@onready var player: Player = $Player
@onready var sprite_2d_2: AnimatedSprite2D = $npc4/Sprite2D2
const INFO_BUBBLE = preload("res://scenes/info_bubble.tscn")
@onready var info_bubble: Control = $Control/info_bubble
@onready var label: Label = $Control/info_bubble/Info
@onready var door_building: AnimatedSprite2D = $DoorBuilding
@onready var collision_shape: CollisionShape2D = $Door_L/CollisionShape2D
const STAGE_1 = preload("res://dialogue/stage_1.dialogue")
@onready var player_sprite: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $npc3/AnimatedSprite2D
@onready var info_animation: AnimationPlayer = $Control/info_bubble/AnimationPlayer
@onready var info_sound: AudioStreamPlayer = $info


func _ready() -> void:
	collision_shape.disabled = true
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.got_dialogue.connect(_on_dialogue_started)
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	DialogueManager.show_dialogue_balloon(STAGE_1, "start")


func _process(delta: float) -> void:
	if Global.talked_two and Global.responded == 0:
		npc_3.position=Vector2(-300,-106)

func _on_level_spawn(destination_tag: String):
	var door_path = "Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

func display_info(info: String, status: String):
	Global.status = status
	Global.info_text = info
	info_bubble.show()
	info_sound.play()
	info_animation.play("fade_in")

func _on_dialogue_ended(resource: DialogueResource):
	print(Global.status)
	InteractionManager.can_interact = true
	player.set_physics_process(true)
	player.set_process_input(true)
	
func _on_dialogue_started(line: DialogueLine):
	InteractionManager.can_interact = false

func stop_moving():
	print("stopped moving")
	player.set_physics_process(false)
	player.set_process_input(false)

func responded_1():
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		info_bubble.show()
		player.set_physics_process(true)
		player.set_process_input(true)
		npc_3.position+=Vector2(1500,10)

func responded_2():
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		info_bubble.show()
		player.set_physics_process(true)
		player.set_process_input(true)
		npc_3.position+=Vector2(1500,10)

func ignored_1():
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		info_bubble.show()
		player.set_physics_process(true)
		player.set_process_input(true)
		npc_3.position+=Vector2(1500,10)
		animated_sprite_2d.scale = Vector2(0.033,0.028)
		animated_sprite_2d.play("default") 
		
func ignored_2():
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		info_bubble.show()
		player.set_physics_process(true)
		player.set_process_input(true)
		npc_3.position=Vector2(-218,-202)
		animated_sprite_2d.scale = Vector2(0.033,0.028)
		animated_sprite_2d.play("default") 
func go_away():
		animated_sprite_2d.play("vanish")
		animated_sprite_2d.scale = Vector2(1,1) 
		await get_tree().create_timer(1.5).timeout
		info_bubble.show()
		player.set_physics_process(true)
		player.set_process_input(true)
		npc_3.position+=Vector2(1500,10)
		
func wand():
		sprite_2d_2.play("wand")
		await get_tree().create_timer(1).timeout
		sprite_2d_2.play("wand_in")
		door_building.play("open")
		collision_shape.disabled = false
