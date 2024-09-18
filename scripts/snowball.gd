extends Node2D

@onready var fella = get_tree().get_root().get_node("Node2D/fella")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var startPos = position.x
var timesPassed = 4
var hasPassed = false
#var poofed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.is_in_group("invert"):
		position.x -= 120 * delta
	else:
		position.x += 120 * delta
		
	if timesPassed >= 4:
		#print(get_tree().get_root().get_node("Node2D/fella"))
		if fella in $Area2D.get_overlapping_bodies():
			#print("HEY COSMIS IT WORKS")
			timesPassed = 0
			fella.hitfall_timer = 30
			fella.velocity.y = -200
			$fwoosh.playing = true
			#$Snowball.offset.y = -24
			$AnimationPlayer.play("snowball_poof")
	else:
		if hasPassed == false and position.x > startPos:
			timesPassed += 1
			hasPassed = true
			#if timesPassed == 4: $Snowball.offset.y = 0
			if timesPassed == 4: $AnimationPlayer.play("snowball_repoof")
		#poofed -= delta
		
	if position.x > 256:
		position.x = 0
		hasPassed = false
	if position.x < 0:
		position.x = 256
		hasPassed = false


#func _on_animation_player_animation_finished(anim_name):
#	if anim_name == "snowball_poof": 
		#poofed = 8
		#position.x = -512
