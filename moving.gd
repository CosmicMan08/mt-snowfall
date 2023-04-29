extends StaticBody2D

#signal player_on_plat

@onready var fella = get_tree().get_root().get_node("Node2D/fella")

# Called when the node enters the scene tree for the first time.
func _ready():
	#fella.connect("player_on_plat",Callable(self,"player_on_plat()"))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += 60 * delta
	
	if position.x > 256: position.x = 0
	if position.x < 0: position.x = 256
	
	#print(get_tree().get_root().get_node("Node2D/fella"))
	if fella in $Area2D.get_overlapping_bodies() and !self.is_in_group("leave_player") and fella.velocity.y == 0:
		#print("HEY COSMIS IT WORKS")
		fella.position.x += 60 * delta
