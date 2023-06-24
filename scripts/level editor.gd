extends Node2D

#pointer x and pointer y, got tired of writing them out in full
var px = 0
var py = 16

@onready var lvl_obj = preload("res://level object.tscn")

var level_array = [[0,1,32,1,0,0],[0,0,32,1,1,0],[5,2,0]]

var quick_access = [
	[0],
	[5],
	[1,0],
	[0,0],
	[1],
	[3]
]

var tool = 0
var tile = 0

var mouse_pos = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	render()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#LET ME OUT LET ME OUTTTTTTTTTTTTTTTTTTTTTTTTTTT
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://title screen.tscn")
	
	
	if mouse_pos != get_viewport().get_mouse_position():
		mouse_pos = get_viewport().get_mouse_position()
		px = round(mouse_pos.x/8 - 0.5)
		py = -round(mouse_pos.y/8 + 0.5) + 30
		
	if Input.is_action_pressed("shift"):
		if Input.is_action_pressed("ui_right"):
			px += 1
		if Input.is_action_pressed("ui_left"):
			px -= 1
		if Input.is_action_pressed("ui_up"):
			py += 1
		if Input.is_action_pressed("ui_down"):
			py -= 1
	else:
		if Input.is_action_just_pressed("ui_right"):
			px += 1
		if Input.is_action_just_pressed("ui_left"):
			px -= 1
		if Input.is_action_just_pressed("ui_up"):
			py += 1
		if Input.is_action_just_pressed("ui_down"):
			py -= 1
			
	$Pointer.position.x = px * 8
	$Pointer.position.y = -py * 8

	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("left_mouse"):
		if py >= 27:
			print(str(px) + " " + str(py))
			if px == 14:
					tile = 0
			elif px == 17:
					tile = 1
			elif px == 20:
					tile = 2
			elif px == 23:
					tile = 3
			elif px == 26:
					tile = 4
			elif px == 29:
					tile = 5
			else: 
				if len(quick_access[tile]) == 2:
					level_array.append([px,py,1,1,quick_access[tile][0],quick_access[tile][1]])
				else:
					level_array.append([px,py,quick_access[tile][0]])
		else:
			if len(quick_access[tile]) == 2:
				level_array.append([px,py,1,1,quick_access[tile][0],quick_access[tile][1]])
			else:
				level_array.append([px,py,quick_access[tile][0]])
		render()
		print(tile)
		
	#print(str(px) + " " + str(py))
		
	if Input.is_action_just_pressed("ui_cancel"):
		var lvl_txt = ""
		for i in level_array:
			for k in i:
				lvl_txt += str(k) + ","
			lvl_txt = lvl_txt.left(lvl_txt.length() - 1)
			lvl_txt += ";"
		lvl_txt = lvl_txt.left(lvl_txt.length() - 1)
		print(lvl_txt)

func render():
	for i in level_array:
		if len(i) == 3 or len(i) == 4:
			$ObjectMap.set_cell(0, Vector2(int(i[0]),-int(i[1]) - 1),0,Vector2(i[2]%5, floor(i[2]/5)),0)
		else:
			for x in i[2]:
				for y in i[3]:
					$TileMap.set_cell(0, Vector2(int(i[0] + x),-int(i[1]) - 1 - y),0,Vector2(i[4],i[5]),0)
	
	for i in range(1,7):
		var item = get_node("CanvasLayer/ParallaxBackground/EditorItem"+str(i))
		if len(quick_access[i-1]) == 1:
			get_node("CanvasLayer/ParallaxBackground/EditorItem"+str(i)+"/ObjectMap").set_cell(0, Vector2(0,0), 0, Vector2(quick_access[i-1][0]%5, floor(quick_access[i-1][0]/5)),0)
			get_node("CanvasLayer/ParallaxBackground/EditorItem"+str(i)+"/TileMap").set_cell(0, Vector2(0,0), 0, Vector2(-1, -1),0)
		else:
			get_node("CanvasLayer/ParallaxBackground/EditorItem"+str(i)+"/TileMap").set_cell(0, Vector2(0,0), 0, Vector2(quick_access[i-1][0], quick_access[i-1][1]),0)
			get_node("CanvasLayer/ParallaxBackground/EditorItem"+str(i)+"/ObjectMap").set_cell(0, Vector2(0,0), 0, Vector2(-1, -1),0)
		
		if i == tile + 1:
			item.frame = 1
		else:
			item.frame = 0
		
	var lvl_txt = ""
	for i in level_array:
		for k in i:
			lvl_txt += str(k) + ","
		lvl_txt = lvl_txt.left(lvl_txt.length() - 1)
		lvl_txt += ";"
	lvl_txt = lvl_txt.left(lvl_txt.length() - 1)
	print(lvl_txt)
