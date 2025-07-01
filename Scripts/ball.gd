extends CharacterBody2D

#Declare Variables
@export var ball: CharacterBody2D
var speed:int=500
#var direction:Vector2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision=move_and_collide(velocity*delta)
	if(collision):
		velocity=velocity.bounce(collision.get_normal())#*1.01
		if(collision.get_collider().has_method("hit")):
			var this_brick=collision.get_collider()
			collision.get_collider().hit(this_brick)
			
func launch(direction:Vector2):
	velocity=direction*speed
	
