extends CharacterBody2D

@onready var progress_bar: ProgressBar = $ProgressBar
var player = get_tree().get_root().get_node("/root/Game/Player")
var speed: float = 0.01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.value = Global.enemyHits


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.value = Global.enemyHits
	look_at(player.global_position)
	self.position = lerp(self.position,player.global_position,speed)
