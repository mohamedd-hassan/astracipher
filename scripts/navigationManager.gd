extends Node

const scene_level_one = preload("res://scenes/level_one.tscn")
const scene_maze = preload("res://scenes/maze.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"level_one":
			scene_to_load = scene_level_one
		"maze":
			scene_to_load = scene_maze
	
	if scene_to_load != null:
		Transition.transition()
		await Transition.on_transition_finished
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
