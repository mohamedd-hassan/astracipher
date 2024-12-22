extends CharacterBody2D

class_name Player 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var follow_point: Marker2D = $FollowPoint

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var direction = "right"
var is_moving = false

func get_input():
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if input_direction:
		is_moving = true
		velocity = input_direction * SPEED
	else:
		is_moving = false
		velocity = Vector2.ZERO

func update_animation():
	if is_moving:
		if velocity.x < 0: 
			direction = "left"
		elif velocity.x > 0: 
			direction = "right"
		elif velocity.y > 0: 
			direction = "down"
		elif velocity.y < 0: 
			direction = "up"
		animated_sprite.play("walk_" + direction)
	else:
		animated_sprite.play("idle_" + direction)

func _physics_process(delta: float) -> void:
	get_input()
	update_animation()
	update_follow_point()
	move_and_slide()

func _ready():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animated_sprite.play("walk")
	animated_sprite.stop()

# there HAS to be a better way to do this but i can't be bothered bsra7a
func update_follow_point():
	if animated_sprite.animation == "idle_down" or animated_sprite.animation == "walk_down":
		follow_point.position = Vector2(0,-20)
	elif animated_sprite.animation == "idle_up" or animated_sprite.animation == "walk_up":
		follow_point.position = Vector2(0,12)
	elif animated_sprite.animation == "idle_right" or animated_sprite.animation == "walk_right":
		follow_point.position = Vector2(-20,4)
	elif animated_sprite.animation == "idle_left" or animated_sprite.animation == "walk_left":
		follow_point.position = Vector2(20,4)
