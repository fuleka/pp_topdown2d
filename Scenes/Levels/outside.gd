extends Level_Parent

func _on_gate_player_entered_gate():
	var tween = create_tween()
	tween.tween_property($player,"speed",0,0.5).from(250)
	Transitionlayer.change_scene("res://Scenes/Levels/inside.tscn")
