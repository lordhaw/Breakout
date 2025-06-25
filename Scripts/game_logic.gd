extends Node2D

# Declare Variables
var brick = preload("res://Scenes/brick.tscn")
@onready var brick_node = $Bricks
var brick_size=Brick.get_brick_size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_brick()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_brick():
	var viewport_size=get_viewport_rect().size
	var rows=(viewport_size.x/2 / brick_size.x) # if you add numbers to the end you can increase rows
	var columns=(viewport_size.y/2 / brick_size.y)+4 #this adds 4 columns to the calculated number
	for col in range(columns):
		for row in range(rows):
			var new_brick = brick.instantiate() #adds a new brick from the brick scene
			# sets the position of a brick; The -2 for the x and y reduces gap between bricks
			# the addition to x pads space from the left to center while the addition to y pads space
			# from the top to leave gap at top
			print("col"+str(col))
			print("row"+str(row))
			new_brick.global_position = Vector2(((brick_size.x-2) * col+65) , ((brick_size.y-2) * row+20))
			brick_node.add_child(new_brick)