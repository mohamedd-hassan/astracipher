extends CharacterBody2D

var is_dying = false
var is_jumping = false
var can_move = true


@export var Gravity = 1000
@export var SPEED = 300.0 
@export var JUMP_VELOCITY = -350.0

@onready var jump_height_timer: Timer = $jump_height_timer
@onready var jump_buffer_timer: Timer = $jump_buffer_timer
@onready var death_timer: Timer = $death_timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D2
@onready var coyote_timer: Timer = $coyote_timer
@onready var jump_sfx: AudioStreamPlayer2D = $jump_sfx

var can_coyote_jump = false
var jump_buffered = false

func _ready() -> void:
	add_to_group("player")
	death_timer.connect("timeout", Callable(self, "_on_DeathTimer_timeout"))

func _physics_process(delta: float) -> void:
	
	if is_dying:
		return
	
	# Add the gravity.
	if !is_on_floor() && !can_coyote_jump:
		if velocity.y < 0:
			velocity.y += Gravity * delta
			velocity.x += Gravity * delta
		elif velocity.y > 1000:
			velocity.y = 1000
		else:
			velocity.y += Gravity * 1.5 * delta
			velocity.x += Gravity * 1.5 * delta
	else:
		is_jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and can_move:
		jump_height_timer.start()
		jump()
		
	var direction := Input.get_axis("move_left", "move_right")
	if can_move:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if !can_move:
		velocity.x = 0
	
	update_animation(direction)
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && !is_on_floor() && not velocity.y < 0:
		can_coyote_jump = true
		coyote_timer.start()
		
	if !was_on_floor && is_on_floor():
		if jump_buffered:
			jump_buffered = false
			jump()
	
func update_animation(direction):
	if is_dying:
		return
	if is_jumping:
		animated_sprite_2d.play("jump")
		if direction !=0:
			animated_sprite_2d.flip_h = (direction<0)
	elif direction != 0 and can_move:
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
		Global.player_lives = 3
		Global.enemies_killed = 0
		get_tree().reload_current_scene()
		

func _on_jump_height_timer_timeout() -> void:
	if !Input.is_action_pressed("jump"):
		if velocity.y < -100:
			velocity.y = -100
			print("low jump")
	else:
		print("high jump")

func _on_jump_buffer_timer_timeout() -> void:
	jump_buffered = false

func _on_coyote_timer_timeout() -> void:
	can_coyote_jump = false

func jump():
	if is_on_floor() || can_coyote_jump:
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()
		is_jumping = true
		if can_coyote_jump:
			can_coyote_jump = false
	else:
		if !jump_buffered:
			jump_buffered = true
			jump_buffer_timer.start()
