extends CharacterBody2D


const SPEED = 100.0
const FLOAT_SPEED = 60.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hitfall_timer = 0
var yawn_timer = randf_range(2,15)
var old_direction = 0
var end = false
var was_on_floor = true
var isFloating = false
var isDiving = false
var hasFloated = false
var wind_dir = 0

func list_files_in_directory(path):
	var files = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)

	dir.list_dir_end()

	return files

func _physics_process(delta):
	if ($AnimationPlayer.current_animation == "fox_yawn" or 
	$AnimationPlayer.current_animation == "fox_snowballed" or 
	$AnimationPlayer.current_animation == "fox_teeter"):
		$Tail.visible = false
	else:
		$Tail.visible = true
	
	if global_position.y > 0: 
		hitfall_timer = 30
		velocity.y = -400
		#velocity.y = 0
	
	$"the wagger".play("tail_wag")
	if end:
		$AnimationPlayer.play("fox_jump")
		velocity.y -= 5
		if position.y < $Camera2D.limit_top - 50:
			var level_id = get_tree().get_current_scene().scene_file_path.replace("res://levels/","").replace(".tscn","")
			if level_id+".tscn" in list_files_in_directory("res://cutscenes"):
				get_tree().change_scene_to_file("res://cutscenes/"+str(int(level_id))+".tscn")
			else:
				get_tree().change_scene_to_file("res://levels/"+str(int(level_id)+1)+".tscn")
	else:
		if not is_on_floor():
			if was_on_floor and not velocity.y < 0:
				$Koyote.start()
			
			if isDiving and hitfall_timer == 0:
				velocity.y += gravity * 6 * delta
			elif Input.is_action_pressed("ui_accept") and velocity.y < 0 and hitfall_timer == 0:
				velocity.y += gravity * delta
			else:
				velocity.y += gravity * 3 * delta
				
			#floating code
			if Input.is_action_just_pressed("move_up") and !hasFloated and hitfall_timer == 0 and !isDiving:
				isFloating = true
				hasFloated = true
				$Float.start()
				
			if isFloating and hitfall_timer == 0:
				velocity.y = 8
			elif isFloating:
				isFloating = false
				
			if Input.is_action_just_released("move_up") or $Float.time_left == 0:
				isFloating = false
				
				
			if Input.is_action_just_pressed("move_down") and !isFloating and hitfall_timer == 0:
				isDiving = true
				velocity.y = 200
				
			if hitfall_timer == 0: #if the fox hasn't been hit by a snowball
				if isFloating:
					$AnimationPlayer.current_animation = "fox_float"
				elif isDiving:
					$AnimationPlayer.current_animation = "fox_dive"
				else:
					if velocity.y < 0:
						$AnimationPlayer.play("fox_jump")
					elif velocity.y > 0:
						$AnimationPlayer.play("fox_fall")
		elif is_on_floor():
			isFloating = false
			isDiving = false
			hasFloated = false
			$Body.offset.y = 0
			$Tail.offset.y = 0
			$Tail.offset.x = 0

		# Handle Jump.
		if Input.is_action_just_pressed("ui_accept"):
			$Buffer.start()
			
		if ($Buffer.time_left > 0 and is_on_floor()) or (Input.is_action_just_pressed("ui_accept") and $Koyote.time_left > 0):
			velocity.y = JUMP_VELOCITY
			$AnimationPlayer.play("fox_jump")
			$jump.playing = true
			
		#move aaa
		var direction = Input.get_axis("move_left", "move_right")
		#print(direction)
		if direction:
			if isFloating: velocity.x = direction * FLOAT_SPEED + wind_dir
			else: velocity.x = direction * SPEED + wind_dir
			
			#if is_on_floor() and $"Turn Around".time_left == 0:
			#	$"Turn Around".start()
			#print(direction)
			
			if is_on_floor(): $AnimationPlayer.play("fox_walk")
			
			$Tail.flip_h = (direction<0)
			$Body.flip_h = (direction<0)
			old_direction = direction
		else:
			if is_on_floor():
				if Input.is_action_pressed("move_up"):
					$Tail.offset.y = -1
					$AnimationPlayer.play("fox_lookup")
				elif Input.is_action_pressed("move_down"):
					$Tail.offset.y = 2
					$AnimationPlayer.play("fox_crouch")
				elif (area_coll($"left check".get_overlapping_bodies())
				!= area_coll($"right check".get_overlapping_bodies())):
					$AnimationPlayer.play("fox_teeter")
				else:
					if yawn_timer > 0 and $AnimationPlayer.current_animation != "fox_yawn":
						$AnimationPlayer.play("fox_idle")
						yawn_timer -= delta
					else:
						$AnimationPlayer.play("fox_yawn")
						yawn_timer = randf_range(2,15)
			velocity.x = move_toward(velocity.x, 0 + wind_dir, SPEED)

		#print($"Turn Around".time_left)
		if is_on_floor() and $"Turn Around".time_left > 0 and clamp(velocity.x,-1,1) != old_direction:
			$AnimationPlayer.current_animation = "turn_around"
		
		#if old_direction != direction and not old_direction and direction: # or old_direction != 0
		#	$"Turn Around".start()
		
		#snowball stuff
		if hitfall_timer > 0:
			$CollisionShape2D.disabled = true
			if not is_in_group("wrapless"):
				$CollisionShape2D2.disabled = true
				$CollisionShape2D3.disabled = true
			hitfall_timer -= 1
			if $AnimationPlayer.current_animation != "fox_snowballed":
				$AnimationPlayer.play("fox_snowballed")
		elif not area_coll($Area2D.get_overlapping_bodies()):
			#print($Area2D.get_overlapping_bodies())
			$CollisionShape2D.disabled = false
			if not is_in_group("wrapless"):
				$CollisionShape2D2.disabled = false
				$CollisionShape2D3.disabled = false

	was_on_floor = is_on_floor()

	move_and_slide()
	
	#screenwrap uwu
	if not is_in_group("wrapless"):
		if position.x > 256: position.x = 0
		if position.x < 0: position.x = 256
	else:
		$Camera2D.limit_right = 10000000
		$CollisionShape2D2.disabled = true
		$CollisionShape2D3.disabled = true
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://title screen.tscn")

func player_on_plat():
	position.x += 1


func _on_area_2d_area_entered(area):
	if area.get_name() == "NoNoClip": 
		hitfall_timer = 0
		$CollisionShape2D.disabled = false
		velocity.y = -1
		
	if area.get_name() == "loop point": 
		position.y += 368
		get_tree().get_root().get_node("Node2D/AudioStreamPlayer").pitch_scale -= 0.01
		
	if area.get_name() == "Ball Area": 
		end = true
		$Camera2D.limit_top = self.position.y - 420
		get_tree().get_root().get_node("Node2D/AudioStreamPlayer").playing = false
		$jingle.playing = true
		get_tree().get_root().get_node("Node2D/CanvasLayer/ui/Timer").timer_going = false
		velocity.x = 0
		velocity.y = 100
		area.get_parent().queue_free()

func area_coll(arr):
	for i in arr:
		if i.get_class() == "TileMap":
			return true
	return false

func _on_animation_player_animation_finished(anim_name):
	pass
