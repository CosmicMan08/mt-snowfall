extends RichTextLabel


var time_elapsed = 0
var timer_going = true

var config = ConfigFile.new()

@onready var rank_times = ["0","0"]

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().get_root().get_node("Node2D/Node") == null:
		rank_times = ["0","9223372036854775800"]
	else:
		rank_times = get_tree().get_root().get_node("Node2D/Node").get_child(0).name.split(",")
	$"../Ranks".visible = false
	config.load("user://save.cfg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var level = int(get_tree().get_current_scene().scene_file_path.replace("res://levels/","").replace(".tscn",""))
	#print(level)
	if timer_going: time_elapsed += delta
	else:
		$"../Ranks".visible = true
		$"../Ranks".frame = clamp(floor((time_elapsed-int(rank_times[0]))/((int(rank_times[1])-int(rank_times[0]))/6))+1,0,6) #magic formula. calculates the ranking checking how far from rank_times[0] to rank_times[1] the player's time is.
		#print(floor((time_elapsed-int(rank_times[0]))/((int(rank_times[1])-int(rank_times[0]))/6))) #magic formula. calculates the ranking checking how far from rank_times[0] to rank_times[1] the player's time is.
		
		if (config.get_value("level_"+str(level),"best_time") == 0) or (time_elapsed < config.get_value("level_"+str(level),"best_time")):
			#print(">~<")
			#print(time_elapsed)
			config.set_value("level_"+str(level), "best_time", time_elapsed)
			config.set_value("level_"+str(level), "rank", $"../Ranks".frame)
			#print(config.get_value("level_"+str(level),"best_time"))
			config.save("user://save.cfg")
	
	self.text = "%02d:%02d:%02d" % [time_elapsed / 60, fmod(time_elapsed, 60), fmod(time_elapsed, 1) * 100]
