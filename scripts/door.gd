extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@onready var spawn: Marker2D = $Spawn

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body is Player:
		print("player entered")
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
	else:
		print("not player entered")
