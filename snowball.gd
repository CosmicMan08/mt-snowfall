extends Node2D

@onready var fella = get_tree().get_root().get_node("Node2D/fella")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += 120 * delta
	
	if position.x > 256: position.x = 0
	if position.x < 0: position.x = 256
	
	#print(get_tree().get_root().get_node("Node2D/fella"))
	if fella in $Area2D.get_overlapping_bodies():
		#print("HEY COSMIS IT WORKS")
		fella.hitfall_timer = 30
		fella.velocity.y = -200
		$fwoosh.playing = true
		$AnimationPlayer.play("snowball_poof")


func _on_animation_player_animation_finished(_anim_name):
	queue_free()
