extends RichTextLabel


var time_elapsed = 0
var timer_going = true

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	config.load("user://save.cfg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var level = int(get_tree().get_current_scene().scene_file_path.replace("res://levels/","").replace(".tscn",""))
	#print(level)
	if timer_going: time_elapsed += delta
	elif (config.get_value("level_"+str(level),"best_time") == 0) or (time_elapsed < config.get_value("level_"+str(level),"best_time")):
		#print(">~<")
		#print(time_elapsed)
		config.set_value("level_"+str(level), "best_time", time_elapsed)
		#print(config.get_value("level_"+str(level),"best_time"))
		config.save("user://save.cfg")
	
	self.text = "%02d:%02d:%02d" % [time_elapsed / 60, fmod(time_elapsed, 60), fmod(time_elapsed, 1) * 100]
