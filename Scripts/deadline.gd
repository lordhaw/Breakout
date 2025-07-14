extends Area2D

#Declare Variables
@onready var fade_animation: AnimationPlayer
var death_audio: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	death_audio=AudioStreamPlayer.new()
	add_child(death_audio)
	var audio_stream=load("res://Sounds/fade_out.mp3")
	death_audio.stream=audio_stream
	body_entered.connect(deadball)
	
func deadball(body):
	if Global.player_lives > 1:
		Global.player_lives -= 1
		body.queue_free() # destroys ball
		State.ball_state = "Docked"
		await destroy_paddle() # think this is obvious ;) await is used due to animation
		owner.start_round()
	else:
		body.queue_free() # destroys ball
		await destroy_paddle()
		var title_audio =get_tree().get_first_node_in_group("game_audio")
		Global.fade_db(title_audio)
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")

func destroy_paddle():
	var old_paddle=get_tree().get_first_node_in_group("paddle") 
	fade_animation=old_paddle.get_child(0).get_child(0)
	death_audio.play()
	fade_animation.play("fade_paddle")
	await fade_animation.animation_finished
	old_paddle.queue_free()
