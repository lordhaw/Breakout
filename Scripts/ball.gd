extends CharacterBody2D

#Declare Variables
@export var ball: CharacterBody2D
var ball_audio: AudioStreamPlayer
var speed:int=500

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ball_spec(delta)
			
func launch(direction:Vector2):
	velocity=direction*speed
	ball_audio=AudioStreamPlayer.new()
	add_child(ball_audio)
	var audio_stream=load("res://Sounds/ball_bounce.mp3")
	ball_audio.stream=audio_stream
	State.ball_state = "Undocked"

func ball_spec(delta: float):
	#Defines behaviour of the ball
	Global.ball_pos=global_position.x
	var collision=move_and_collide(velocity*delta)
	if(collision && State.ball_state == "Undocked"):
		ball_audio.play()
		velocity=velocity.bounce(collision.get_normal())*1.001 #multiplier speeds up ball slowly after collision
		if(collision.get_collider().has_method("hit")):
			var this_brick=collision.get_collider()
			collision.get_collider().hit(this_brick)