extends Node2D

# Declare Variables
var brick = preload("res://Scenes/brick.tscn")
var ball:PackedScene=load("res://Scenes/ball.tscn")
var paddle:PackedScene=load("res://Scenes/paddle.tscn")
var countdown_animation: AnimationPlayer
var music_player: AudioStreamPlayer
var brick_size=Brick.get_brick_size()
var new_paddle
var new_ball
var new_powerup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func _process(delta: float) -> void:
	check_ball_state(delta)
	check_brick_count()
	
func start_game():
	countdown_animation=get_tree().get_first_node_in_group("countdown animation")

	#set up background music
	music_player=AudioStreamPlayer.new()
	music_player.add_to_group("game_audio")
	add_child(music_player)
	var audio_stream=load("res://Sounds/Tank.mp3")
	music_player.stream=audio_stream
	music_player.volume_db = -10
	music_player.play()
	
	#set up gameboard
	spawn_brick()
	start_round()
	
	
func start_round():
	countdown_animation.play("countdown_animation")
	await countdown_animation.animation_finished
	
	#spawn or respawn paddle and ball once countdown is done
	spawn_paddle()
	State.ball_state = "Docked"
	spawn_ball()
		
func spawn_brick():
	
	var viewport_size=get_viewport_rect().size
	var rows = 8 
	var columns=(viewport_size.x/2 / brick_size.x)+8
	for col in range(columns):
		for row in range(rows):
			var new_brick = brick.instantiate()
			Global.brick_count += 1
			# sets the colour of the brick dependant on row
			match row:
				0:
					 # red
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/red_rounded_rectangle.png")
					sprite.texture=new_texture
					State.brick_state = "Red"
				1:
					# yellow
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/yellow_rounded_rectangle.png")
					sprite.texture=new_texture
					State.brick_state = "Yellow"
				2:
					# orange
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/orange_rounded_rectangle.png")
					sprite.texture=new_texture
					State.brick_state = "Orange"
				3:
					# green
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/green_rounded_rectangle.png")
					sprite.texture=new_texture
					State.brick_state = "Green"
				4:
					# dark grey
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/dkgrey_rounded_rectangle.png")
					sprite.texture=new_texture
					State.brick_state = "DkGrey"
				5:
					# dark blue
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/dkblue_rounded_rectangle.png")
					sprite.texture=new_texture
					State.brick_state = "DkBlue"
				6:
					# dark purple
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/dkpurple_rounded_rectangle.png")
					sprite.texture=new_texture
					State.brick_state = "DkPurple"
				7:
					# light blue
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/blue_rounded_rectangle.png")
					sprite.texture=new_texture
					State.brick_state = "Blue"
					
			
			# sets the position of a brick; The 1.3 multiplier for y reduces gap between bricks
			# note that changing texture for sprite2d for brick may require adjustment like above one to x as well as y
			# the addition to x pads space from the left to center while the addition to y pads space 
			# from the top to leave gap at top
			new_brick.global_position = Vector2(((brick_size.x) * col+90) , ((brick_size.y*1.3) * row+50))
			get_tree().root.get_child(0).add_child(new_brick)
			
func spawn_ball():
	new_ball=ball.instantiate()
	new_ball.global_position=get_viewport().get_visible_rect().size/2
	new_ball.global_position.y=new_paddle.global_position.y-10
	#var launch_angle = randf_range(-PI/4,PI/4)
	#var direction=Vector2.UP.rotated(launch_angle) 
	#new_ball.launch(direction)
	get_tree().root.get_child(0).add_child(new_ball)
	
func spawn_paddle():
	new_paddle=paddle.instantiate()
	new_paddle.global_position=(get_viewport().get_visible_rect().size/2) #centers the paddle
	new_paddle.global_position.y=new_paddle.global_position.y+300 #moves paddle down
	get_tree().root.get_child(0).add_child(new_paddle)
	
func check_ball_state(delta: float):
	if(State.ball_state == "Docked"):
		#locks ball to paddle
		var speed: int=10
		if(new_paddle != null && new_ball != null):
			if(Global.ball_pos > new_paddle.global_position.x):
				new_ball.global_position.x =lerp(new_ball.global_position.x, new_paddle.global_position.x + speed, 3*(speed*6)*delta)
			elif(Global.ball_pos < new_paddle.global_position.x):
				new_ball.global_position.x =lerp(new_ball.global_position.x, new_paddle.global_position.x - speed, 3*(speed*6)*delta)
	elif(State.ball_state == "Launched"):
		#if space pressed to launch ball, determine angle based off paddle positioning
		#launch angle for not moving is set so it's not straight up, allowing for better initial ball bouncing
		var launch_angle
		if(Global.paddle_direction == "Left"):
			launch_angle = -PI/4
		elif(Global.paddle_direction == "Right"):
			launch_angle = PI/4
		else:
			launch_angle = -0.05

		var direction=Vector2.UP.rotated(launch_angle) 
		new_ball.launch(direction)
		
func check_brick_count():
	if(Global.brick_count == 0):
		#prep to start new round
		var old_paddle=get_tree().get_first_node_in_group("paddle")
		var old_ball=get_tree().get_first_node_in_group("ball")
		old_paddle.queue_free()
		old_ball.queue_free()
		spawn_brick()
		start_round()

