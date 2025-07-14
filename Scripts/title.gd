extends CanvasLayer

# Declare Variables
var music_player: AudioStreamPlayer
var pointer = load("res://Sprites/pointer.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(pointer)
	music_player=AudioStreamPlayer.new()
	music_player.add_to_group("title_audio")
	add_child(music_player)
	var audio_stream=load("res://Sounds/Focused Minds.mp3")
	music_player.stream=audio_stream
	music_player.volume_db = -10
	music_player.play()



