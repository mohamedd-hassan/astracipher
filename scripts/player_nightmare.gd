extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var follow_point: Marker2D = $FollowPoint

const SPEED = 500.0
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
	move_and_slide()

func _ready():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animated_sprite.play("walk")
	animated_sprite.stop()
