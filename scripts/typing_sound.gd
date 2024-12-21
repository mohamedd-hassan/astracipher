extends Control

var visible_characters = 0
func _ready() -> void:
	$AnimationPlayer.play("typing")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible_characters != $RichTextLabel.visible_characters:
		visible_characters = $RichTextLabel.visible_characters
		$AudioStreamPlayer2D.play()
