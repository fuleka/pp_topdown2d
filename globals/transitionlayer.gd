extends CanvasLayer

func _ready():
	$ColorRect.modulate = Color(0,0,0,0)

func change_scene(traget: String) -> void:
	$AnimationPlayer.play("fadetoblack")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play_backwards("fadetoblack")
	get_tree().call_deferred("change_scene_to_file",traget)
