extends CharacterBody2D


const SPEED = 25

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	velocity.y += gravity * delta
	
	velocity.x = -SPEED
	update_animation()
	move_and_slide()


func update_animation():
	animated_sprite_2d.play("hop")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		queue_free()
