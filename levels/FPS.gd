extends RichTextLabel

var config = ConfigFile.new()

func _ready():
	config.load("user://save.cfg")

func _process(_delta):
	set_text(str(Engine.get_frames_per_second()))
	
	visible = config.get_value("Settings", "fps_counter")
