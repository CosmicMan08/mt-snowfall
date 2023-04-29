extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$"1".frame = self.frame
	$"2".frame = self.frame
	$"1".offset = self.offset
	$"2".offset = self.offset
	$"1".flip_h = self.flip_h
	$"2".flip_h = self.flip_h
