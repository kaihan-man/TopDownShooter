extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $HealthBar

const SPEED = 350.0

func _process(delta: float) -> void:
	# Update healthbar
	health_bar.value = Global.playerHits
	
	# Get the input vector for movement
	var input_vector = Input.get_vector("Left", "Right", "Up", "Down")
	
	# Update the position based on input
	position += input_vector * SPEED * delta
	
	# Check which way the player is facing
	if Input.is_action_pressed("Right"):
		animated_sprite_2d.flip_h = false
	
	if Input.is_action_pressed("Left"):
		animated_sprite_2d.flip_h = true
		
	# Check if there is movement
	if input_vector != Vector2.ZERO:
		# Choose animation based on direction
		if input_vector.x > 0:
			animated_sprite_2d.play("Run")
		elif input_vector.x < 0:
			animated_sprite_2d.play("Run")
		elif input_vector.y > 0:
			animated_sprite_2d.play("Run")
		elif input_vector.y < 0:
			animated_sprite_2d.play("Run")
	else:
		# Play Idle
		animated_sprite_2d.play("Idle")
