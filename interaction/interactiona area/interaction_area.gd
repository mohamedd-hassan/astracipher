extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"

var interact: Callable = func():
	pass


func _on_body_entered(body: Node2D) -> void:
	print("body entered")
	InteractionManager.register_area(self)
	



func _on_body_exited(body: Node2D) -> void:
	print("body exited")
	InteractionManager.unregister_area(self)
