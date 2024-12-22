extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _ready() -> void:
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

func _process(delta: float) -> void:
	pass

func _on_level_spawn(destination_tag: String):
	var door_path = "Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)



func _on_puzzle_1_interaction_body_entered(body: Node2D) -> void:
	print("entered puzzle 1")
	if body.is_in_group("Player"):
		print("player entered puzzle 1")
		player.set_physics_process(false)
		player.set_process_input(false)
		animation_player.play("npc1_in")
		await animation_player.animation_finished
		player.set_physics_process(true)
		player.set_process_input(true)


func _on_puzzle_2_interaction_body_entered(body: Node2D) -> void:
	print("entered puzzle 2")
	if body.is_in_group("Player"):
		print("player entered puzzle 2")
		player.set_physics_process(false)
		player.set_process_input(false)
		animation_player.play("screen_down")
		await animation_player.animation_finished
		animation_player.play("npc2_turn")
		await animation_player.animation_finished
		player.set_physics_process(true)
		player.set_process_input(true)
