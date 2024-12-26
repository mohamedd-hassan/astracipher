extends Control


func _ready() -> void:
	pass  # Replace with function body if needed

# Function to handle the Back button press
func _on_back_pressed():
	print("back")
	get_tree().change_scene_to_file("res://scenes/pause_menu_1.tscn")
