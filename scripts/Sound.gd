extends AudioStreamPlayer

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	config.load("user://save.cfg")
	volume_db = config.get_value("Settings", "sound") / 5 - 25
	if config.get_value("Settings", "sound") <= 0: volume_db = -100
