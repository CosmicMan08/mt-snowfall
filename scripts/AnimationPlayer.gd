extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	match get_tree().get_current_scene().scene_file_path.replace("res://cutscenes/","").replace(".tscn",""):
		"4":
			play("sleep")
		"8":
			play("cutscene fall")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_finished(anim_name):
	var id = get_tree().get_current_scene().scene_file_path.replace("res://cutscenes/","").replace(".tscn","")
	get_tree().change_scene_to_file("res://levels/"+str(int(id)+1)+".tscn")
