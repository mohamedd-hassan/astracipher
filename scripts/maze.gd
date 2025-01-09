extends Node2D

@onready var point_light: PointLight2D = $Player/PointLight2D
@onready var knowledge_light_animation: AnimationPlayer = $Player/PointLight2D/AnimationPlayer
@onready var astra_animation: AnimatedSprite2D = $Astra/AnimatedSprite2D2
@onready var player: Player = $Player
@onready var cutscene_animation: AnimationPlayer = $CutsceneAnimation
@onready var spawn: Marker2D = $Door_L/Spawn
@onready var player_animation: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var drone: AnimatedSprite2D = $Drone
@onready var interaction_area: Area2D = $InteractionArea
@onready var solved_maze: CollisionShape2D = $SolvedMaze/CollisionShape2D
@onready var door_l: CollisionShape2D = $Door_L/CollisionShape2D
@onready var progress_bar: TextureProgressBar = $stopwatch/Stopwatch/TextureProgressBar
@onready var stopwatch: Control = $stopwatch/Stopwatch
@onready var timer: Timer = $stopwatch/Stopwatch/Timer
@onready var water: AudioStreamPlayer = $water
@onready var chase: AudioStreamPlayer = $chase
@onready var end_level: AnimationPlayer = $SolvedMaze/EndLevel
@onready var hope: AudioStreamPlayer = $hope

const MAZE = preload("res://dialogue/maze.dialogue")

var time = 0.0
var animation_end = false

func _ready() -> void:
	solved_maze.disabled = true
	solved_maze.visible = false
	drone.visible = false
	door_l.disabled = true
	player.global_position = spawn.global_position
	water.play()


func _process(delta: float) -> void:
	update_astra_animation()
	point_light.texture_scale = Dialogic.VAR.Knowledge
	if !Global.met_cipher:
		astra_animation.play("idle_down")
	knowledge_light_animation.play("flicker")
	if Global.met_cipher:
		solved_maze.disabled = false
		solved_maze.visible = true
		if Dialogic.VAR.Knowledge <= 0.5:
			point_light.texture_scale = 0.5
			time = 50
			timer.wait_time = 50
			point_light.texture_scale = timer.time_left * 0.01
		else:
			time = Dialogic.VAR.Knowledge / 0.01
			timer.wait_time = time
			point_light.texture_scale = timer.time_left * 0.01
		progress_bar.value = (timer.time_left / time) * 100

func update_astra_animation():
	if Global.met_cipher and Global.cutscene_end:
		astra_animation.play(player_animation.animation)
	
func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.met_cipher = true
		print("entered body (ew?)")
		cutscene()
func start_timer():
	drone.visible = false
	stopwatch.visible = true
	player.set_physics_process(true)
	player.set_process_input(true)
	timer.start()
	
func cutscene():
	water.stop()
	Global.met_cipher = true
	interaction_area.queue_free()
	print("should play animation")
	player.set_physics_process(false)
	player.set_process_input(false)
	cutscene_animation.play("walk_to_astra")
	await cutscene_animation.animation_finished
	DialogueManager.show_dialogue_balloon(MAZE, "astracipher")
	await DialogueManager.dialogue_ended
	Global.cutscene_end = true


func _on_timer_timeout() -> void:
	lost()
	
func _on_solved_maze_body_entered(body: Node2D) -> void:
	print("SOMEONE ENTERED")
	if body is Player:
		print("PLAYER WON")
		won()
	
func lost():
	end_level.play("end_level")
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/lost.tscn")
	
func won():
	end_level.play("end_level")
	Transition.transition2()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/won.tscn")
	
