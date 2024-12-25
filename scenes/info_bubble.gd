extends Control
@onready var info_bubble: Control = $"."

#var text_to_show=Dialogic.VAR.text1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resume():
	print("continue func")
	get_tree().paused= false
	
func _on_continue_pressed() -> void:
	self.hide()
	print("CONTIUE")
	resume()
