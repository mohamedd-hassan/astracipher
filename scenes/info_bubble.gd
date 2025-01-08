extends Control

@onready var lost_won: Label = $LostWon
@onready var info: Label = $Info
@onready var info_bubble: Control = $"."
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if Global.status == "lost":
		lost_won.text = "You lost 10% Knowledge!"
	elif Global.status == "won":
		lost_won.text = "You gained 10% Knowledge!"
	info.text = Global.info_text

func _on_button_pressed() -> void:
	animation_player.play("fade_out")
	await animation_player.animation_finished
	info_bubble.visible = false
