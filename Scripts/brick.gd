extends RigidBody2D

class_name Brick

static func get_brick_size():
	# adjusting these will adjust the gap between bricks
	var brick_x=65	
	var brick_y=25
	return Vector2(brick_x,brick_y)
	
	
