extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pitfall_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()


func _on_win_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.has_won = true
		Dialogic.VAR.Knowledge += Global.enemies_killed/10
		get_tree().change_scene_to_file("res://scenes/maze.tscn")
