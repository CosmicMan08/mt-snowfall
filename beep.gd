extends StaticBody2D

const timing = 4
@onready var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if self.is_in_group("2"):
		$AnimationPlayer.play("pulsate_2")
		timer = timing/2
	else:
		$AnimationPlayer.play("pulsate")
		timer = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer < timing: timer += delta
	else: timer = 0
	
	if timer < timing/2:
		$AnimationPlayer.current_animation = "pulsate"
		$CollisionShape2D.disabled = false
	else:
		$AnimationPlayer.current_animation = "pulsate_2"
		$CollisionShape2D.disabled = true
		
	print(timer)
