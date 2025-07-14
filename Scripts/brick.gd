class_name Brick
extends StaticBody2D

static func get_brick_size():
	# adjusting these will adjust the gap between bricks
	var brick_x=65	
	var brick_y=25
	return Vector2(brick_x,brick_y)
	
static func hit(body):
	#Sets score based on colour of brick hit
	match State.brick_state:
		"Red":
			Global.player_score += 5
		"Yellow":
			Global.player_score += 5
		"Orange":
			Global.player_score += 4
		"Green":
			Global.player_score += 4
		"DkGrey":
			Global.player_score += 3
		"DkBlue":
			Global.player_score += 3
		"DkPurple":
			Global.player_score += 2
		"Blue":
			Global.player_score += 1
	
	# removes brick hit
	
	body.queue_free()
	Global.brick_count -= 1


	
	
	
	
