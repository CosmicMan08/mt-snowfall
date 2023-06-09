extends StaticBody2D

@onready var fella = get_tree().get_root().get_node("Node2D/fella")
@onready var level = get_tree().get_root().get_node("Node2D/TileMap")
@onready var start_pos = position.y

var falling = false
var broken = false
var icicle_timer = 0
var restoration_timer = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if falling and level in $Area2D2.get_overlapping_bodies():
		$AudioStreamPlayer.playing = true
		$AnimationPlayer.play("ice_shatter")
		falling = false
		broken = true
		
	if fella in $Area2D.get_overlapping_bodies() and fella.velocity.y == 0 and !falling and !broken:
		#print("HEY COSMIS IT WORKS")
		#print("uwu")
		$AnimationPlayer.play("ice_shaking")
		falling = true
	if falling and icicle_timer < 0.08:
		icicle_timer += delta
	elif falling and !broken:
		$AnimationPlayer.play("ice_idle")
		position.y += 2
		$TileMap.set_layer_enabled(0, false)
		restoration_timer = 3
		
	if restoration_timer > 0 and broken:
		restoration_timer -= delta
	elif broken:
		$AnimationPlayer.play("ice_shaking")
		falling = false
		if position.y > start_pos: position.y -= 2
		else:
			icicle_timer = 0
			restoration_timer = 3
			broken = false
			$AnimationPlayer.play("ice_idle")
			$TileMap.set_layer_enabled(0, true)
		
	#print(position.y)
	#print($Timer.time_left)
