extends CharacterBody2D


var SPEED = 60
var facing_right = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_alive = true
var distance_travelled = 0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var player_side: CharacterBody2D = get_parent().get_parent().get_node("PlayerSide")

@export var distance_to_move = 40

var player_position
var target_position

func _ready() -> void:
	add_to_group("enemy")
	
func _physics_process(delta: float) -> void:
	
	player_position = player_side.position
	target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
		position += target_position * SPEED * delta
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if position.x == distance_to_move or endOfPlatform():
		flip()
	
	
	
	
	#position.x += SPEED * delta
	distance_travelled += velocity.x
	update_animation()
	move_and_slide()


func update_animation():
	animated_sprite_2d.play("idle")


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_alive = false
		Global.enemies_killed += 1
		animated_sprite_2d.play("death")
		await animated_sprite_2d.animation_finished
		queue_free()

func flip():
	distance_travelled = 0
	facing_right = !facing_right
	scale.x = abs(scale.x) * -1
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1
	
	
func endOfPlatform():
	return !ray_cast_2d.is_colliding() && is_on_floor()
