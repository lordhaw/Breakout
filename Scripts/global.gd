extends Node

#Declare Variables

var player_score: int = 0
var player_lives: int = 3
var brick_count: int = 0
var hit_brick_pos: Vector2
var ball_pos: float
var paddle_direction: String

# Global Functions
func fade_db(audio_node):
	var fade_tween = create_tween()
	#var title_audio =get_tree().get_first_node_in_group("title_audio")
	fade_tween.tween_property(audio_node, "volume_db", -80, 3.0)
	await get_tree().create_timer(1.0).timeout