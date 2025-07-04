extends Node2D

# Declare Variables
var brick = preload("res://Scenes/brick.tscn")
var ball:PackedScene=load("res://Scenes/ball.tscn")
var paddle:PackedScene=load("res://Scenes/paddle.tscn")
var countdown_animation: AnimationPlayer
var brick_size=Brick.get_brick_size()
var new_paddle
var new_ball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

	
func start_game():
	
	countdown_animation=get_tree().get_first_node_in_group("countdown animation")
	
	spawn_brick()
	spawn_paddle()
	start_round()
	
	
func start_round(): 
	countdown_animation.play("countdown_animation")
	await countdown_animation.animation_finished
	spawn_ball()
	
func spawn_brick():
	
	var viewport_size=get_viewport_rect().size
	var rows = 8
	var columns=(viewport_size.x/2 / brick_size.x)+9
	for col in range(columns):
		for row in range(rows):
			var new_brick = brick.instantiate()
			
			# sets the colour of the brick dependant on row
			match row:
				0:
					 # red
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/red_rounded_rectangle.png")
					sprite.texture=new_texture
				1:
					# yellow
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/yellow_rounded_rectangle.png")
					sprite.texture=new_texture
				2:
					# orange
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/orange_rounded_rectangle.png")
					sprite.texture=new_texture	
				3:
					# green
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/green_rounded_rectangle.png")
					sprite.texture=new_texture
				4:
					# dark grey
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/dkgrey_rounded_rectangle.png")
					sprite.texture=new_texture
				5:
					# dark blue
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/dkblue_rounded_rectangle.png")
					sprite.texture=new_texture
				6:
					# dark purple
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/dkpurple_rounded_rectangle.png")
					sprite.texture=new_texture
				7:
					# light blue
					var sprite = new_brick.get_node("Sprite2D")
					var new_texture = preload("res://Sprites/blue_rounded_rectangle.png")
					sprite.texture=new_texture
					
			
			# sets the position of a brick; The 1.3 multiplier for y reduces gap between bricks
			# note that changing texture for sprite2d for brick may require adjustment like above one to x as well as y
			# the addition to x pads space from the left to center while the addition to y pads space 
			# from the top to leave gap at top
			new_brick.global_position = Vector2(((brick_size.x) * col+56) , ((brick_size.y*1.3) * row+40))
			get_tree().root.get_child(0).add_child(new_brick)
			
func spawn_ball():
	new_ball=ball.instantiate()
	new_ball.global_position=get_viewport().get_visible_rect().size/2
	new_ball.global_position.y=new_paddle.global_position.y-10
	var launch_angle = randf_range(-PI/4,PI/4)
	var direction=Vector2.UP.rotated(launch_angle) 
	new_ball.launch(direction)
	get_tree().root.get_child(0).add_child(new_ball)
	
func spawn_paddle():
	new_paddle=paddle.instantiate()
	new_paddle.global_position=(get_viewport().get_visible_rect().size/2) #centers the paddle
	new_paddle.global_position.y=new_paddle.global_position.y+300 #moves paddle down
	get_tree().root.get_child(0).add_child(new_paddle)
	
