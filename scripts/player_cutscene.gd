extends CharacterBody2D

const GRAVITY = 200.0
const WALK_SPEED = 75
var direction = "right"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D2


func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("move_left"):
		direction = "left"
		velocity.x = -WALK_SPEED
		animated_sprite.play("walk_left")
	elif Input.is_action_pressed("move_right"):
		direction = "right"
		velocity.x = WALK_SPEED
		animated_sprite.play("walk_right")
	else:
		velocity.x = 0
		if direction == "left":
			animated_sprite.play("idle_left")
		else:
			animated_sprite.play("idle_right")

	move_and_slide()
