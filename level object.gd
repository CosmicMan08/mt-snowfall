extends Area2D

@onready var editor_manager = get_tree().get_root().get_node("Node2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	if editor_manager.tool == 1 and Input.is_action_just_pressed("left_mouse"):
		pass
