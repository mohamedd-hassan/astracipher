extends Node2D

@onready var circle_transition: Control = $circle_transition


func _ready() -> void:
	circle_transition


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_win_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.has_won = true
		Dialogic.VAR.Knowledge += Global.enemies_killed/10
		NavigationManager.go_to_level("level_two", null)
