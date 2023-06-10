extends Node2D

@onready var objects = {
	-1: preload("res://objects/png of jack black.tscn"),
	0: preload("res://objects/fella.tscn"),
	1: preload("res://objects/snowball.tscn"),
	2: preload("res://objects/air_block.tscn"),
	3: preload("res://objects/platform.tscn"),
	4: preload("res://objects/end_ball.tscn"),
	5: preload("res://objects/wind_controller.tscn"),
	6: preload("res://objects/icicle.tscn"),
	7: preload("res://objects/cloud.tscn"),
	8: preload("res://objects/cloud.tscn")
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var level_string = str("0,1,32,1,0,0;0,0,32,1,1,0;7,3,0;0,6,7,32;0,12,8,32;0,18,7,32;0,24,8,32;0,30,7,32")
	var object_array = Array(level_string.split(";"))
	var level_array = Array()
	for i in object_array.size():
		#print(object_array[i].split(","))
		level_array.append_array([Array(object_array[i].split(","))])
		for k in level_array[i].size():
			#print(level_array[i][k])
			level_array[i][k] = int(level_array[i][k])
	print(level_array)

	for i in level_array:
		#print(i)
		if len(i) == 3 or len(i) == 4:
			#print("hi :3")
			var silly = objects[i[2]].instantiate()
			silly.position.x = (i[0]) * 8
			silly.position.y = (-i[1] - 1) * 8
			if i[2] == 0: silly.set_name("fella")
			if i[2] == 8: silly.add_to_group("2")
			#print(silly.get_name())
			if len(i) == 4:
				for k in i[3]:
					print(k)
					silly = objects[i[2]].instantiate()
					silly.position.x = (i[0]) + k * 8
					silly.position.y = (-i[1] - 1) * 8
					if i[2] == 8: silly.add_to_group("2")
					add_child(silly)
			else:
				add_child(silly)
		else:
			for x in i[2]:
				#print(x)
				for y in i[3]:
					#print(y)
					#print(i)
					$TileMap.set_cell(0, Vector2(int(i[0] + x),-int(i[1]) - 1 - y),0,Vector2(i[4],i[5]),0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
