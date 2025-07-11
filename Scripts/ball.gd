extends CharacterBody2D

#Declare Variables
@export var ball: CharacterBody2D
var ball_audio: AudioStreamPlayer
var speed:int=500



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.ball_pos=global_position.x
	var collision=move_and_collide(velocity*delta)
	if(collision && State.ball_state == "Undocked"):
		ball_audio.play()
		velocity=velocity.bounce(collision.get_normal())*1.01
		if(collision.get_collider().has_method("hit")):
			var this_brick=collision.get_collider()
			collision.get_collider().hit(this_brick)
			
func launch(direction:Vector2):
	velocity=direction*speed
	ball_audio=AudioStreamPlayer.new()
	add_child(ball_audio)
	var audio_stream=load("res://Sounds/ball_bounce.wav")
	ball_audio.stream=audio_stream
