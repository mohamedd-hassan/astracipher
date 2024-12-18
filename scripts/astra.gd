extends CharacterBody2D

@export var parent : CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D2
@onready var follow_point = parent.get_node("FollowPoint")

var speed = 100
var direction = "right"
func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if Global.met_cipher and Global.cutscene_end:
		var target = follow_point.global_position
		velocity = Vector2.ZERO
		if position.distance_to(target) > 5:
			velocity = position.direction_to(target) * speed
			print(velocity)

		move_and_slide()
		
