extends Node

@export var quiz : QuizTheme
@export var color_right : Color
@export var color_wrong : Color
@onready var circle_transition: Control = $circle_transition

var buttons : Array[Button]
var index : int 
var correct : int 

var current_quiz : QuizQuestion:
	get: return quiz.theme[index]


@onready var question_texts: Label = $ColorRect/Content/QuestionInfo/QuestionText

func _ready():
	circle_transition
	correct = 0
	for button in $ColorRect/Content/QuestionHolder .get_children():
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
		correct += 1
	else:
		button.modulate = color_wrong
		
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
	$ColorRect/Content/GameOver.show()
	$ColorRect/Content/GameOver/Score.text = str(correct, "/", quiz.theme.size())
	print("hhhhhh")
	Global.has_finished_quiz = true
	NavigationManager.go_to_level("level_two", null)
	
func on_button_pressed():
	pass
