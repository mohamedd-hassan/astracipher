extends Control


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass  # Replace with function body if needed

func _on_start_pressed() -> void:
	NavigationManager.go_to_level("nightmare", null)

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_resources_pressed() -> void:
	OS.shell_open("https://en.wikipedia.org/wiki/Internet_safety")
