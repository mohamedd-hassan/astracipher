extends Node

@export var quiz : QuizTheme
@export var color_right : Color
@export var color_wrong : Color

var buttons : Array[Button]
var index : int 
var correct : int 

var current_quiz : QuizQuestion:
	get: return quiz.theme[index]

@onready var question_texts: Label = $TextureRect/Content/QuestionText
@onready var you_lost: Label = $you_lost
@onready var damn_bruh: Label = $damn_bruh
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $TextureRect/Timer
@onready var texture_progress_bar: TextureProgressBar = $TextureRect/TextureProgressBar
@onready var score: Label = $Score

func _process(delta: float) -> void:
	texture_progress_bar.value = (timer.time_left / 120) * 100

func _ready():
	timer.start()
	correct = 0
	for button in $TextureRect/Content/QuestionHolder .get_children():
		buttons.append(button)
		
	#randomize_array(quiz.theme)
		
	load_quiz()
	
		
func load_quiz():
	if index >= quiz.theme.size():
		game_over()
		return
	question_texts.text = current_quiz.question_info
	
	var options = current_quiz.options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(buttons_answer.bind(buttons[i]))
		
	match quiz.theme[index].type:
		Enum.QuestionType.TEXT:
			pass
		
func buttons_answer(button):
	if current_quiz.correct == button.text : 
		button.modulate = color_right
		$AudioCorrect.play()
		correct += 1
	else:
		button.modulate = color_wrong
		$wrong.play()
		
	next_question()
		
func next_question():
	for bt in buttons:
		bt.pressed.disconnect(buttons_answer)
		
	await get_tree().create_timer(0.5).timeout
	for bt in buttons:
		bt.modulate = Color.WHITE
		
	index += 1
	load_quiz()
	
	
#func randomize_array(array: Array) -> Array:
	#var array_temp = array
	#array_temp.shufle()
	#return array_temp
	
func game_over():
	Global.has_finished_quiz = true
	if correct <= 3:
		you_lost.visible = true
		damn_bruh.visible = true
		score.visible = true
		score.text = str(correct, "/", quiz.theme.size())
		animation_player.play("lost")
		await animation_player.animation_finished
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scenes/level_two1.tscn")
	else:
		$great_job.visible = true
		$you_won.visible = true
		score.visible = true
		score.text = str(correct, "/", quiz.theme.size())
		animation_player.play("won")
		await animation_player.animation_finished
		Transition.transition()
		await Transition.on_transition_finished
		get_tree().change_scene_to_file("res://scenes/level_two1.tscn")
	# $TextureRect/Content/GameOver.show()
	# $TextureRect/Content/GameOver/Score.text = str(correct, "/", quiz.theme.size())
	
func on_button_pressed():
	get_tree().reload_current_scene()

		


func _on_timer_timeout() -> void:
	you_lost.visible = true
	damn_bruh.visible = true
	score.visible = true
	score.text = str(correct, "/", quiz.theme.size())
	animation_player.play("lost")
	await animation_player.animation_finished
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/level_two1.tscn")
