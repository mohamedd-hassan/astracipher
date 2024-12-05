extends VBoxContainer

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	


func _on_resources_pressed() -> void:
	OS.shell_open("https://youtu.be/dQw4w9WgXcQ?si=6B2t5Tp8DxLhVOUi")
