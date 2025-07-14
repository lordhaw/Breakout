class_name Paddle
extends CharacterBody2D

#Declare Variables
@export var paddle: CharacterBody2D
var speed: int=10
var direction: String


# The process function runs every frame the game runs, many times a second
func _process(delta: float) -> void:
	paddle_spec(delta)
	
func paddle_spec(delta):
	#movement decision tree
	if(self.velocity.is_zero_approx()):
		Global.paddle_direction = "Stopped"
	if(Input.is_action_pressed("Left")):
		global_position.x -=speed
		direction = "left"
		Global.paddle_direction = "Left"
	elif(Input.is_action_pressed("Right")):
		global_position.x +=speed
		direction = "right"
		Global.paddle_direction = "Right"

	if(Input.is_action_pressed("Shoot")):
		State.ball_state = "Launched"

	if(Input.is_action_pressed("Boom")):
		Global.brick_count = 0

	global_position.x=clamp(global_position.x,40,get_viewport_rect().size.x -40)