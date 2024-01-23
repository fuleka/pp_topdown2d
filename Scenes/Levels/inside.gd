extends Level_Parent

var outside_scene: PackedScene = preload("res://Scenes/Levels/outside.tscn")

func _on_exitgate_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($player, "speed", 0, 0.5)
	get_tree().change_scene_to_file('res://Scenes/Levels/outside.tscn')
	
