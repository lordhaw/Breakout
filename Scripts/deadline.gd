extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(deadball)
	
func deadball(body):
	body.queue_free()
	owner.start_round()
	


