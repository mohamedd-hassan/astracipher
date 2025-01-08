extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var puzzle_1_npc_collision = $Puzzle1Npc/CollisionShape2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var player_animator: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var puzzle_1_npc: CharacterBody2D = $Puzzle1Npc
@onready var puzzle_2_npc_collision: CollisionShape2D = $Puzzle2Npc/CollisionShape2D
@onready var door: Door = $Door_L
@onready var npc2_animation: AnimatedSprite2D = $Puzzle2Npc/AnimatedSprite2D
@onready var music: AudioStreamPlayer2D = $music

var has_done_npc1_puzzle = false
var has_done_npc2_puzzle = false

const STAGE_2 = preload("res://dialogue/stage_2.dialogue")

func _ready() -> void:
	door.queue_free()
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	if Global.player_position != null:
		player.global_position = Global.player_position
	else:
		player.global_position = marker_2d.global_position

func _process(delta: float) -> void:
	pass

func _on_level_spawn(destination_tag: String):
	var door_path = "Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)


func _on_puzzle_1_interaction_body_entered(body: Node2D) -> void:
	print("entered puzzle 1")
	if body.is_in_group("Player"):
		if Global.has_won == false:
			print("player entered puzzle 1")
			player.set_physics_process(false)
			player.set_process_input(false)
			player_animator.play("idle_right")
			animation_player.play("npc1_in")
			await animation_player.animation_finished
			DialogueManager.show_dialogue_balloon(STAGE_2, "npc1")
			await DialogueManager.dialogue_ended
			player.set_physics_process(true)
			player.set_process_input(true)
			Global.player_position = player.global_position
			NavigationManager.go_to_level("windows", null)
			
		elif Global.has_won == true and has_done_npc1_puzzle == false:
			print("player finished puzzle 1")
			player.set_physics_process(false)
			player.set_process_input(false)
			player_animator.play("idle_right")
			puzzle_1_npc.global_position.x = 366
			DialogueManager.show_dialogue_balloon(STAGE_2, "npc1")
			await DialogueManager.dialogue_ended
			animation_player.play("npc1_out")
			await animation_player.animation_finished
			puzzle_1_npc_collision.disabled = true
			player.set_physics_process(true)
			player.set_process_input(true)
			has_done_npc1_puzzle = true

func _on_puzzle_2_interaction_body_entered(body: Node2D) -> void:
	print("entered puzzle 2")
	if body.is_in_group("Player"):
		if Global.has_finished_quiz == false:
			print("player entered puzzle 2")
			player.set_physics_process(false)
			player.set_process_input(false)
			player_animator.play("idle_right")
			animation_player.play("screen_down")
			await animation_player.animation_finished
			animation_player.play("npc2_turn")
			await animation_player.animation_finished
			DialogueManager.show_dialogue_balloon(STAGE_2, "npc2")
			await DialogueManager.dialogue_ended
			player.set_physics_process(true)
			player.set_process_input(true)
			Global.player_position = player.global_position
			NavigationManager.go_to_level("quiz", null)
		elif Global.has_finished_quiz and has_done_npc2_puzzle == false:
			print("player finished puzzle 2")
			player.set_physics_process(false)
			player.set_process_input(false)
			player_animator.play("idle_right")
			npc2_animation.play("idle_left")
			DialogueManager.show_dialogue_balloon(STAGE_2, "npc2")
			await DialogueManager.dialogue_ended
			puzzle_2_npc_collision.disabled = true
			player.set_physics_process(true)
			player.set_process_input(true)
			has_done_npc2_puzzle = true


func _on_go_to_maze_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body is Player:
		print("player entered")
		NavigationManager.go_to_level("maze_cutscene", null)
func music_stops():
	music.stop()

func music_plays():
	music.play()
