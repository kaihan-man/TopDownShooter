extends Node2D

#Export varaibles are editable in the inspector
@export var bullet_speed:float = 500
const REVOLVER_BULLET = preload("res://Scenes/revolver_bullet.tscn")
@onready var hurt_sfx: AudioStreamPlayer = $HurtSFX
@onready var die_sfx: AudioStreamPlayer = $DieSFX

#Pushes the bullet on the postive X axis AKA forwards. This is then multiplyed by speed to choose how fast, and delta to make it the same speed for all pc's
func _process(delta:float) -> void:
	position += transform.x * bullet_speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Enemy":
		Global.enemyHits += 1
		hurt_sfx.play()
		queue_free()
		if Global.enemyHits >= 3:
			print("found")
			Global.enemyHits == 0
			body.queue_free()
			queue_free()
			die_sfx.play()
