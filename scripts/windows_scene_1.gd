extends Node2D

@onready var win: Area2D = $win
@onready var player_side: CharacterBody2D = $TileMapLayer/PlayerSide
@export var next_scene: PackedScene

var player_scene: PackedScene = load("res://scenes/player_side.tscn")
var player_nodes = player_scene.instantiate()

var player_side_animatedsprite:AnimatedSprite2D = player_nodes.get_node("AnimatedSprite2D")

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
		cutscene()
		

func cutscene():
	win.queue_free()
	player_side.set_process_input(false)
	player_side_animatedsprite.play("idle")
	Dialogic.start("windows_scene_1_timeline")
	await Dialogic.timeline_ended
	player_side.set_process_input(true)
	get_tree().change_scene_to_packed(next_scene)
	
