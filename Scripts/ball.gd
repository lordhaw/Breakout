extends CharacterBody2D

#Declare Variables
var speed:int=500
#var direction:Vector2
@export var ball: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity=Vector2.UP*speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var collision=move_and_collide(velocity*delta)
	if(collision):
		velocity=velocity.bounce(collision.get_normal())#*1.01
