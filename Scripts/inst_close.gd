extends TextureButton


func _ready() -> void:
	pressed.connect(close)


func close():
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
