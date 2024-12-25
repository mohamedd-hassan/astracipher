extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	get_tree().paused = false
	animation_player.play("RESET") 
	pass

func resume():
	print("resume func")
	animation_player.play_backwards("blur")
	get_tree().paused = false

func pause():
	print("pause func")
	get_tree().paused = true
	animation_player.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()

func _on_resume_pressed() -> void:
	print("RESUME")
	resume()

func _on_quit_pressed() -> void:
	print("QUIT")
	get_tree().paused = false
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _process(delta: float) -> void:
	testEsc()


func _on_options_pressed() -> void:
	print("options")
	get_tree().change_scene_to_file("res://scenes/options_menu_2.tscn")
