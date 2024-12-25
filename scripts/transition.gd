extends CanvasLayer

signal on_transition_finished

@onready var color_rect_2: ColorRect = $ColorRect2
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	color_rect.visible = false
	color_rect_2.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)
	
func transition():
	color_rect.visible = true
	animation_player.play("fade_to_black")

func transition2():
	color_rect_2.visible = true
	animation_player.play("fade_to_white")

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black" or anim_name == "fade_to_white":
		on_transition_finished.emit()
		animation_player.play("fade_to_scene")
	elif anim_name == "fade_to_scene":
		color_rect.visible = false
		color_rect_2.visible = false
