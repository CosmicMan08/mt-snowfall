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
	playing = true
