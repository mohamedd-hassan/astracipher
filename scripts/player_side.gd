extends CharacterBody2D

var is_dying = false
var is_jumping = false

const SPEED = 300.0
const JUMP_VELOCITY = -325.0

@onready var death_timer: Timer = $death_timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	add_to_group("player")
	death_timer.connect("timeout", Callable(self, "_on_DeathTimer_timeout"))

func _physics_process(delta: float) -> void:
	
	if is_dying:
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		is_jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	update_animation(direction)

	move_and_slide()

func update_animation(direction):
	if is_dying:
		return
	if is_jumping:
		animated_sprite_2d.play("jump")
	elif direction != 0:
		animated_sprite_2d.flip_h = (direction<0)
		animated_sprite_2d.play("run")
	else: 
		animated_sprite_2d.play("idle")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and body.is_alive:
		die()
		
func die():
	if is_dying:
		return
	is_dying = true
	animated_sprite_2d.play("die")
	death_timer.start(2.0)
	move_player_up_and_down()
	
func move_player_up_and_down():
	var start_position = position
	var up_position = start_position + Vector2(0, -100)
	var down_position = start_position + Vector2(0, 600)
	
	while position.y > up_position.y:
		position.x -= 2
		position.y -= 4
		await get_tree().create_timer(0.01).timeout
		
	while position.y < down_position.y:
		position.y += 4
		await get_tree().create_timer(0.01).timeout

func _on_DeathTimer_timeout():
	Global.player_lives -= 1
	if Global.player_lives > 0:
		Global.enemies_killed = 0
		get_tree().reload_current_scene()
	else: 
		Dialogic.VAR.Knowledge -= 0.3
		get_tree().change_scene_to_file("res://scenes/maze.tscn")
