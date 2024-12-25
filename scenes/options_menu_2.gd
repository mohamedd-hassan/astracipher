extends Control

# URL for the resources link
const RESOURCES_URL = "https://example.com"  # Replace with your actual URL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body if needed

# Function to handle the Resources button press
func _on_resources_pressed():
	# Open the resources URL in the default web browser
	if OS.shell_open(RESOURCES_URL) == OK:
		print("Opened resources link: ", RESOURCES_URL)
	else:
		print("Failed to open resources link.")

# Function to handle the Back button press
func _on_back_pressed():
	print("back")
	get_tree().change_scene_to_file("res://scenes/pause_menu_2.tscn")
