extends Sprite2D

var level = 1
var mode = 0

var in_settings = false

const title_theme = preload("res://title screen.wav")
const settings_theme = preload("res://settings.wav")

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if config.load("user://save.cfg") != OK:
		print("uwu")
		config.set_value("Settings", "avalanche", false)
		config.set_value("Settings", "fps_counter", false)
		config.set_value("Settings", "fps_limit", 60)
		config.set_value("Settings", "music", 50)
		config.set_value("Settings", "sound", 50)
		config.set_value("Settings", "snow", false)
		config.save("user://save.cfg")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if in_settings:
		if mode == 0:
			if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
				config.set_value("Settings", "avalanche", !config.get_value("Settings", "avalanche"))
				$Avalanche_Value.text = str(config.get_value("Settings", "avalanche"))
				config.save("user://save.cfg")
		elif mode == 1:
			if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
				config.set_value("Settings", "fps_counter", !config.get_value("Settings", "fps_counter"))
				$FPS_Value.text = str(config.get_value("Settings", "fps_counter"))
				config.save("user://save.cfg")
		elif mode == 2:
			if Input.is_action_pressed("ui_cancel"):
				if Input.is_action_just_pressed("ui_right"):
					config.set_value("Settings", "fps_limit", config.get_value("Settings", "fps_limit") + 1)
				if Input.is_action_just_pressed("ui_left"):
					config.set_value("Settings", "fps_limit", config.get_value("Settings", "fps_limit") - 1)
			else:
				if Input.is_action_just_pressed("ui_right"):
					config.set_value("Settings", "fps_limit", config.get_value("Settings", "fps_limit") + 5)
				if Input.is_action_just_pressed("ui_left"):
					config.set_value("Settings", "fps_limit", config.get_value("Settings", "fps_limit") - 5)
			$Limit_Value.text = str(config.get_value("Settings", "fps_limit"))
			config.save("user://save.cfg")
		elif mode == 3:
			if Input.is_action_pressed("ui_cancel"):
				if Input.is_action_just_pressed("ui_right"):
					config.set_value("Settings", "music", config.get_value("Settings", "music") + 1)
				if Input.is_action_just_pressed("ui_left"):
					config.set_value("Settings", "music", config.get_value("Settings", "music") - 1)
			else:
				if Input.is_action_just_pressed("ui_right"):
					config.set_value("Settings", "music", config.get_value("Settings", "music") + 10)
				if Input.is_action_just_pressed("ui_left"):
					config.set_value("Settings", "music", config.get_value("Settings", "music") - 10)
			$Music_Value.text = str(config.get_value("Settings", "music"))
			config.save("user://save.cfg")
			$AudioStreamPlayer.volume_db = config.get_value("Settings", "music") / 5 - 25
			if config.get_value("Settings", "music") <= 0: $AudioStreamPlayer.volume_db = -100
		elif mode == 4:
			if Input.is_action_pressed("ui_cancel"):
				if Input.is_action_just_pressed("ui_right"):
					config.set_value("Settings", "sound", config.get_value("Settings", "sound") + 1)
				if Input.is_action_just_pressed("ui_left"):
					config.set_value("Settings", "sound", config.get_value("Settings", "sound") - 1)
			else:
				if Input.is_action_just_pressed("ui_right"):
					config.set_value("Settings", "sound", config.get_value("Settings", "sound") + 10)
				if Input.is_action_just_pressed("ui_left"):
					config.set_value("Settings", "sound", config.get_value("Settings", "sound") - 10)
			$Sound_Value.text = str(config.get_value("Settings", "sound"))
			config.save("user://save.cfg")
		elif mode == 5:
			if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left"):
				config.set_value("Settings", "snow", !config.get_value("Settings", "snow"))
				$Snow_Value.text = str(config.get_value("Settings", "snow"))
				config.save("user://save.cfg")
			
		if Input.is_action_just_pressed("ui_up"): mode -= 1
		if Input.is_action_just_pressed("ui_down"): mode += 1
		
		mode = mode%9
		if mode < 0: mode = 8
		$Pointer.position.y = 24 + (8 * mode)
		
		if Input.is_action_just_pressed("ui_accept") and mode == 8:
			#$AudioStreamPlayer.stream = settings_theme
			in_settings = false
			
			$Progress.visible = true
			$Endless.visible = true
			$Options.visible = true
			$RichTextLabel.visible = true
			$BestTimer.visible = true
			
			$Avalanche.visible = false
			$FPS.visible = false
			$Limit.visible = false
			$Music.visible = false
			$Sound.visible = false
			$Snow.visible = false
			$Levels.visible = false
			$Editor.visible = false
			$Back.visible = false
			
			$Avalanche_Value.visible = false
			$FPS_Value.visible = false
			$Limit_Value.visible = false
			$Music_Value.visible = false
			$Sound_Value.visible = false
			$Snow_Value.visible = false
	else:
		if $Timer.time_left == 0:
			if Input.is_action_just_pressed("ui_right"): level += 1
			if Input.is_action_just_pressed("ui_left"):  level -= 1 
			
			if Input.is_action_just_pressed("ui_up"): mode -= 1
			if Input.is_action_just_pressed("ui_down"): mode += 1
			
			mode = mode%3
			if mode < 0: mode = 2
				
			$RichTextLabel.text = "MOUNTAIN " + str(level) 

			$Pointer.position.y = 24 + (16 * mode)
			
			if Input.is_action_just_pressed("ui_accept") and mode != 2:
				$Timer.start()
				$AudioStreamPlayer.playing = false
				$jingle.playing = true
			elif Input.is_action_just_pressed("ui_accept"):
				#$AudioStreamPlayer.stream = settings_theme
				in_settings = true
				
				$Progress.visible = false
				$Endless.visible = false
				$Options.visible = false
				$RichTextLabel.visible = false
				$BestTimer.visible = false
				
				$Avalanche.visible = true
				$FPS.visible = true
				$Limit.visible = true
				$Music.visible = true
				$Sound.visible = true
				$Snow.visible = true
				$Levels.visible = true
				$Editor.visible = true
				$Back.visible = true
			
				$Avalanche_Value.visible = true
				$FPS_Value.visible = true
				$Limit_Value.visible = true
				$Music_Value.visible = true
				$Sound_Value.visible = true
				$Snow_Value.visible = true
				
				$Avalanche_Value.text = str(config.get_value("Settings", "avalanche"))
				$FPS_Value.text = str(config.get_value("Settings", "fps_counter"))
				$Limit_Value.text = str(config.get_value("Settings", "fps_limit"))
				$Music_Value.text = str(config.get_value("Settings", "music"))
				$Sound_Value.text = str(config.get_value("Settings", "sound"))
				$Snow_Value.text = str(config.get_value("Settings", "snow"))
		elif $Timer.time_left < 0.5:
			config.save("user://save.cfg")
			if mode == 0: get_tree().change_scene_to_file("res://levels/"+str(level)+".tscn")
			elif mode == 1: get_tree().change_scene_to_file("res://levels/endless.tscn")
		else:
			if int($Timer.time_left*4) % 2:
				if mode == 0: $Progress.visible = false
				else: $Endless.visible = false
			else:
				if mode == 0: $Progress.visible = true
				else: $Endless.visible = true

		print(mode)

	if config.get_value("level_"+str(level),"best_time") != null:
		var time_elapsed = config.get_value("level_"+str(level),"best_time")
		$BestTimer.text = "%02d:%02d:%02d" % [time_elapsed / 60, fmod(time_elapsed, 60), fmod(time_elapsed, 1) * 100]
	else:
		config.set_value("level_"+str(level),"best_time",0)
