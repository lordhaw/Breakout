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

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	print(viewport_size.x)
	for col in range(columns):
		for row in range(rows):
			var new_brick = brick.instantiate()
			# sets the position of a brick; The -2 for the x and y reduces gap between bricks
			# the addition to x pads space from the left to center while the addition to y pads space 
			# from the top to leave gap at top
			new_brick.global_position = Vector2(((brick_size.x-2) * col+65) , ((brick_size.y-2) * row+40))
			get_tree().root.get_child(0).add_child(new_brick)
			
func spawn_ball():
	new_ball=ball.instantiate()
	new_ball.global_position=get_viewport().get_visible_rect().size/2
	print(new_paddle.global_position.y)
	print(new_ball.global_position.y)
	new_ball.global_position.y=new_paddle.global_position.y-10
	# for now launching the ball at random; will change
	var direction=Vector2.from_angle(randf_range(20,330)) 
	new_ball.launch(direction)
	get_tree().root.get_child(0).add_child(new_ball)
	
func spawn_paddle():
	new_paddle=paddle.instantiate()
	new_paddle.global_position=(get_viewport().get_visible_rect().size/2) #centers the paddle
	new_paddle.global_position.y=new_paddle.global_position.y+300 #moves paddle down
	get_tree().root.get_child(0).add_child(new_paddle)
	
	
