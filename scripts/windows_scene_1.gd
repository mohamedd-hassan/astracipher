extends Node2D

@onready var win: Area2D = $win
@onready var player_side: CharacterBody2D = $PlayerSide
@export var next_scene: PackedScene
@onready var player_side_animatedsprite: AnimatedSprite2D = $PlayerSide/AnimatedSprite2D2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var circle_transition: Control = $circle_transition


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	circle_transition


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pitfall_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
	
func _on_win_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.can_move = false
		Dialogic.VAR.Knowledge += Global.enemies_killed/10
		await cutscene()
		body.can_move = true

func cutscene():
	win.queue_free()
	player_side_animatedsprite.play("idle")
	animation_player.play("cutscene")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(next_scene)
	
