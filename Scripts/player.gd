extends CharacterBody2D


const SPEED = 350.0


func _process(delta: float) -> void:
	position += Input.get_vector("Left", "Right", "Up", "Down") * SPEED * delta
