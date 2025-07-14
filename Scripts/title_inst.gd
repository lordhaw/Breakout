extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(start_inst)


func start_inst():
	var title_audio =get_tree().get_first_node_in_group("title_audio")
	Global.fade_db(title_audio)
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Scenes/instructions.tscn")
