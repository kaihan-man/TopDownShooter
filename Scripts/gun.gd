extends Node2D

#Players animated sprite refrence
@onready var animated_sprite := $AnimatedSprite2D
#Cooldown timer/tracker
@onready var cooldown_tracker:SceneTreeTimer
#Cooldown in seconds
@export var cooldown:float = 1
#Preloaded revolver bullet from files
const REVOLVER_BULLET = preload("res://Scenes/revolver_bullet.tscn")

@onready var revolver_shot_sfx: AudioStreamPlayer = $RevolverShotSFX
@onready var barrel: ColorRect = $Barrel
@onready var revolver_cock_sfx: AudioStreamPlayer = $RevolverCockSFX


func _ready() -> void:
	#Make fire_cooldown not equal to null
	cooldown_tracker = get_tree().create_timer(0)


func _process(delta: float) -> void:
	#Rotate The Gun To Face The Same Direction As The Player
	look_at(get_global_mouse_position())
	#Limit Rotation
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -2
	else:
		scale.y = 2
	
	#Fire When LMB
	if Input.is_action_just_pressed("LMB"):
		#When The Coodown Is Done Fire
		if not cooldown_tracker.time_left > 0:
			shoot()
			
func shoot():
		#Play the cock sound and shoot animation
		animated_sprite.play("Shoot")
		revolver_cock_sfx.play()
		#Spawn bullet and mirror players rotation and position
		cooldown_tracker = get_tree().create_timer(cooldown)
		await get_tree().create_timer(0.5).timeout
		revolver_shot_sfx.play()
		var bullet_instance = REVOLVER_BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = barrel.global_position
		bullet_instance.rotation = rotation
