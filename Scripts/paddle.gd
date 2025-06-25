extends CharacterBody2D

#Declare Variables
var speed: int=10

# The process function runs every frame the game runs, many times a second
func _process(delta: float) -> void:
	if(Input.is_action_pressed("Left")):
		global_position.x -=speed

	if(Input.is_action_pressed("Right")):
		global_position.x +=speed


	global_position.y=clamp(global_position.y,80,get_viewport_rect().size.y -80)
