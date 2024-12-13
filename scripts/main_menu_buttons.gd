extends VBoxContainer

func _on_play_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/level_one.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")
	

func _on_quit_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().quit()
