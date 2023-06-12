extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_enter"):
		if paused:
			get_tree().paused = true
			$AudioStreamPlayer.play()
			paused = false
			visible = true
		else:
			get_tree().paused = false
			paused = true
			visible = false
