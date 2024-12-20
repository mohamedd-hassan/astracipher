extends Node2D

@onready var point_light: PointLight2D = $Player/PointLight2D
@onready var knowledge_light_animation: AnimationPlayer = $Player/PointLight2D/AnimationPlayer
@onready var astra_animation: AnimatedSprite2D = $Astra/AnimatedSprite2D2
@onready var player: Player = $Player
@onready var cutscene_animation: AnimationPlayer = $CutsceneAnimation
@onready var spawn: Marker2D = $Door_L/Spawn
@onready var player_animation: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var drone: AnimatedSprite2D = $Drone
@onready var stopwatch: Stopwatch = $Player/Camera2D/Stopwatch
@onready var timer: Timer = $Player/Camera2D/Stopwatch/Timer
@onready var interaction_area: Area2D = $InteractionArea

var animation_end = false

func _ready() -> void:
	drone.visible = false
	player.global_position = spawn.global_position
	Dialogic.signal_event.connect(_on_dialogic_signal)


func _process(delta: float) -> void:
	update_astra_animation()
	point_light.texture_scale = Dialogic.VAR.Knowledge
	if !Global.met_cipher:
		astra_animation.play("idle_down")
	knowledge_light_animation.play("flicker")
	if Global.met_cipher:
		point_light.texture_scale = timer.time_left / 300


func _on_dialogic_signal(argument:String):
	if argument == "move_forward":
		cutscene_animation.play("move_forward")
	elif argument == "astra_turn1":
		cutscene_animation.play("astra_turn1")
	elif argument == "astra_turn2":
		cutscene_animation.play("astra_turn2")
	elif argument == "zoom_out":
		cutscene_animation.play("zoom_out")
	elif argument == "drone_in":
		drone.visible = true
		drone.play("idle")
		cutscene_animation.play("drone_in")
	elif argument == "lights_off":
		cutscene_animation.play("lights_off")
	elif argument == "drone_out":
		cutscene_animation.play("drone_out")
	elif argument == "knowledge_light":
		cutscene_animation.play("knowledge_light")
		await cutscene_animation.animation_finished
		point_light.visible = true
	elif argument == "timer":
		drone.visible = false
		stopwatch.visible = true
		player.set_physics_process(true)
		player.set_process_input(true)
		timer.start()
		
func update_astra_animation():
	if Global.met_cipher and Global.cutscene_end:
		astra_animation.play(player_animation.animation)
	
func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.met_cipher = true
		print("entered body")
		cutscene()
	
func cutscene():
	Global.met_cipher = true
	interaction_area.queue_free()
	print("should play animation")
	player.set_physics_process(false)
	player.set_process_input(false)
	cutscene_animation.play("walk_to_astra")
	await cutscene_animation.animation_finished
	Dialogic.start("astracipher_timeline")
	await Dialogic.timeline_ended
	Global.cutscene_end = true


func _on_timer_timeout() -> void:
		lost()

func lost():
	pass # fades to black and text appears, then game ends
	
func won():
	pass # fades to white and text appears, then game ends
	
func _on_solved_maze_body_entered(body: Node2D) -> void:
	won()
