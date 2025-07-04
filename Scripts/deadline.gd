extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(deadball)
	
func deadball(body):
	if Global.player_lives > 1:
		Global.player_lives -= 1
		body.queue_free()
		owner.start_round()
	else:
		print("Game Over")
		get_tree().quit()
		


