extends Node2D
const KNOWLEDGE_VARIATION = 0.1

@onready var point_light: PointLight2D = $Player/PointLight2D
@onready var knowledge_light_animation: AnimationPlayer = $Player/PointLight2D/AnimationPlayer
@onready var astra_animation: AnimatedSprite2D = $Astra/AnimatedSprite2D2
@onready var player: Player = $Player
@onready var cutscene_animation: AnimationPlayer = $CutsceneAnimation
@onready var spawn: Marker2D = $Door_L/Spawn
@onready var player_animation: AnimatedSprite2D = $Player/AnimatedSprite2D2

var met_cipher = false

func _ready() -> void:
	player.global_position = spawn.global_position


func _process(delta: float) -> void:
	point_light.texture_scale = Dialogic.VAR.Knowledge
	if !met_cipher:
		astra_animation.play("idle_down")
	knowledge_light_animation.play("flicker")
	
func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Player:
		met_cipher = true
		print("entered body")
		cutscene()
	
func cutscene():
	print("should play animation")
	cutscene_animation.play("walk_to_astra")
