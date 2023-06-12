extends AudioStreamPlayer

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	config.load("user://save.cfg")
	volume_db = config.get_value("Settings", "music") / 5 - 25
	if config.get_value("Settings", "music") <= 0: volume_db = -100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_finished():
	if name != "cutscene": playing = true
	elif name == "cutscene":
		var id = get_tree().get_current_scene().scene_file_path.replace("res://cutscenes/","").replace(".tscn","")
		get_tree().change_scene_to_file("res://levels/"+str(int(id)+1)+".tscn")
