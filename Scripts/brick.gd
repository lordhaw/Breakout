class_name Brick
extends StaticBody2D

func _ready():
	pass
	#body_entered.connect(this_brick)
	
static func get_brick_size():
	# adjusting these will adjust the gap between bricks
	var brick_x=65	
	var brick_y=25
	return Vector2(brick_x,brick_y)
	
static func hit(body):
	Global.player_score += 1
	body.queue_free()


	
	
	
	
	
