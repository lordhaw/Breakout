extends CharacterBody2D

#Declare Variables
@export var paddle: CharacterBody2D
var speed: int=10
var direction: String



# The process function runs every frame the game runs, many times a second
func _process(delta: float) -> void:
	if(Input.is_action_pressed("Left")):
		global_position.x -=speed
		direction = "left"

	if(Input.is_action_pressed("Right")):
		global_position.x +=speed
		direction = "right"

	global_position.x=clamp(global_position.x,40,get_viewport_rect().size.x -40)
