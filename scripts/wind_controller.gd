extends Node2D

@onready var fella = get_tree().get_root().get_node("Node2D/fella")

var wind_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(wind_timer)
	wind_timer += delta
	
	if wind_timer > 0 and wind_timer < 3:
		$CanvasLayer/ParallaxBackground/TextureRect.visible = true
		
		$CanvasLayer/ParallaxBackground/TextureRect.flip_h = false
		$CanvasLayer/ParallaxBackground/TextureRect/"1".flip_h = false
		$CanvasLayer/ParallaxBackground/TextureRect/"2".flip_h = false
		
		$CanvasLayer/ParallaxBackground/TextureRect.position.x = 510.2 * fmod(wind_timer, 0.5)
		
		$fwoosh.playing = true
		
		fella.wind_dir = 32 
	elif wind_timer > 6 and wind_timer < 9:
		$CanvasLayer/ParallaxBackground/TextureRect.visible = true
		
		$CanvasLayer/ParallaxBackground/TextureRect.flip_h = true
		$CanvasLayer/ParallaxBackground/TextureRect/"1".flip_h = true
		$CanvasLayer/ParallaxBackground/TextureRect/"2".flip_h = true
		
		$CanvasLayer/ParallaxBackground/TextureRect.position.x = -510.2 * fmod(wind_timer, 0.5)
		
		$fwoosh.playing = true
		
		fella.wind_dir = -32
	elif wind_timer > 12: wind_timer = 0
	else:
		$CanvasLayer/ParallaxBackground/TextureRect.visible = false
		fella.wind_dir = 0
