extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0


#var Knowledge = 0.5

#func _ready() -> void:
	#Dialogic.signal_event.connect(_on_dialogic_signal)

#func _on_dialogic_signal(argument:String):
	#if argument == "gain":
		#Knowledge += 0.1
	#if argument == "lose":
		#Knowledge -= 0.1
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta\
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	move_and_slide()
