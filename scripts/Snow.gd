extends AnimationPlayer

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	config.load("user://save.cfg")
	if config.get_value("Settings", "snow"):
		get_parent().get_node("Snow").visible = true
		get_parent().get_node("Snow/Snow2").visible = true
		play("snowing")
	else:
		get_parent().get_node("Snow").visible = false
		get_parent().get_node("Snow/Snow2").visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
