extends Node2D

@onready var win: Area2D = $win
@onready var player_side: CharacterBody2D = $PlayerSide
@export var next_scene: PackedScene
@onready var player_side_animatedsprite: AnimatedSprite2D = $PlayerSide/AnimatedSprite2D2
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
	#player_side.set_physics_process(false)
	#player_side.set_process_input(false)
	#set_process_unhandled_input(false)
	player_side_animatedsprite.play("idle")
	#Dialogic.start("windows_scene_1_timeline")
	#await Dialogic.timeline_ended
	animation_player.play("cutscene")
	await animation_player.animation_finished
	#player_side.set_physics_process(true)
	#player_side.set_process_input(true)
	#set_process_unhandled_input(true)
	get_tree().change_scene_to_packed(next_scene)
	
