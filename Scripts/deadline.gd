extends Area2D

#Declare Variables
@onready var fade_animation: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(deadball)
	
func deadball(body):
	if Global.player_lives > 1:
		Global.player_lives -= 1
		body.queue_free() # destroys ball
		State.ball_state = "Docked"
		await destroy_paddle() # think this is obvious ;)
		owner.start_round()
	else:
		print("Game Over")
		get_tree().quit()

func destroy_paddle():
	var old_paddle=get_tree().get_first_node_in_group("paddle") 
	fade_animation=old_paddle.get_child(0).get_child(0)
	fade_animation.play("fade_paddle")
	await fade_animation.animation_finished
	old_paddle.queue_free()
