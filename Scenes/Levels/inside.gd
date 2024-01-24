extends Level_Parent

func _on_exitgate_body_entered(_body):
	var tween = create_tween()
	tween.tween_property($player,"speed",0,0.5).from(250)
	Transitionlayer.change_scene("res://Scenes/Levels/outside.tscn")
