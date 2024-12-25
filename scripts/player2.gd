extends CharacterBody2D

const SPEED = 115.0
const JUMP_VELOCITY = -250.0
var direction = "right"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("move_right"):
		direction = "right"
		velocity.x = SPEED
		animated_sprite.play("walk_right")
	elif Input.is_action_pressed("move_left"):
		direction = "left"
		velocity.x = -SPEED
		animated_sprite.play("walk_left")
	else:
		velocity.x = 0
		animated_sprite.play("idle_" + direction)
		
	move_and_slide()
