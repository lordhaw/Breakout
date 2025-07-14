extends TextureButton


func _ready() -> void:
	pressed.connect(start_game)


func start_game():
	# reset all globals and states to defaults
	Global.player_lives = 3
	Global.player_score = 0
	Global.brick_count = 0
	State.ball_state = "Docked"
	State.brick_state = "Grey"
	# wipe out remaining objects before starting game again
	var old_paddle=get_tree().get_first_node_in_group("paddle")
	if(old_paddle != null):
		old_paddle.queue_free()
	var old_ball=get_tree().get_first_node_in_group("ball")
	if(old_ball != null):
		old_ball.queue_free()
	var old_bricks=get_tree().get_nodes_in_group("brick")
	if(old_bricks != null):
		for brick in old_bricks:
			print(brick)
			brick.queue_free()
	#restart game
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
