extends AudioStreamPlayer

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	config.load("user://save.cfg")
	volume_db = config.get_value("Settings", "sound") / 5 - 25
	if config.get_value("Settings", "sound") <= 0: volume_db = -100

func _on_finished():
	if name == "nuh uh":
		get_parent().get_node("AudioStreamPlayer").volume_db = config.get_value("Settings", "music") / 5 - 25
