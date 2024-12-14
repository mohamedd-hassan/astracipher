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
var animation_end = false

func _ready() -> void:
	player.global_position = spawn.global_position
	Dialogic.signal_event.connect(_on_dialogic_signal)


func _process(delta: float) -> void:
	point_light.texture_scale = Dialogic.VAR.Knowledge
	if !met_cipher:
		astra_animation.play("idle_down")
	knowledge_light_animation.play("flicker")

func _on_dialogic_signal(argument:String):
	if argument == "move_forward":
		cutscene_animation.play("move_forward")
	
func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Player:
		met_cipher = true
		print("entered body")
		cutscene()
	
func cutscene():
	print("should play animation")
	player.set_physics_process(false)
	player.set_process_input(false)
	cutscene_animation.play("walk_to_astra")
	await cutscene_animation.animation_finished
	print("dialogue")
	Dialogic.start("astracipher_timeline")
	await Dialogic.timeline_ended
