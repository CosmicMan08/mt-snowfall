extends StaticBody2D

@onready var fella = get_tree().get_root().get_node("Node2D/fella")
@onready var tilemap = get_tree().get_root().get_node("Node2D/TileMap")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > 256: position.x = 0
	if position.x < 0: position.x = 256

	if fella in $Area2D.get_overlapping_bodies():
		fella.velocity.y = -256
		$AnimationPlayer.play("block_blow")
		$fwoosh.playing = true
		
	if fella in $Area2Dagain.get_overlapping_bodies():
		if fella.get_node("Body").flip_h: position.x += -1
		else: position.x += 1
		$skrt.playing = true
		if tilemap in $Area2Dthethird.get_overlapping_bodies():
			if fella.get_node("Body").flip_h: position.x += 1.1
			else: position.x += -1.1
