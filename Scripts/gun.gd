extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const REVOLVER_BULLET = preload("res://Scenes/revolver_bullet.tscn")

var Rev_bullets_scene = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -2
	else:
		scale.y = 2
	
	if Input.is_action_just_pressed("LMB"):
		Rev_bullets_scene += 1
		print(Rev_bullets_scene)
		
		if Rev_bullets_scene > 1:
			Rev_bullets_scene = 0
			
		elif Rev_bullets_scene == 1:
			animated_sprite_2d.play("Shoot")
			await get_tree().create_timer(0.5).timeout
			var bullet_instance = REVOLVER_BULLET.instantiate()
			get_tree().root.add_child(bullet_instance)
			bullet_instance.global_position = global_position
			bullet_instance.rotation = rotation
			Rev_bullets_scene -= 1
			
			
