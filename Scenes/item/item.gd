extends Area2D

var rotation_speed: int = 4
var available_option = ['laser', 'granade', 'health']
var type = available_option[randi() %len(available_option)]
var direction: Vector2
var distance: int = randi_range(200,300)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(0.1,0.2,0.8)
	if type == 'granade':
		$Sprite2D.modulate = Color(0.8,0.2,0.1)
	if type == 'health':
		$Sprite2D.modulate = Color(0.1,0.8,0.2)	
	
	var target_pos = position + direction * distance
	var movement_tween = create_tween()
	movement_tween.set_parallel(true)
	movement_tween.tween_property(self,"position",target_pos,0.5)
	movement_tween.tween_property(self,"scale",Vector2(1,1),0.5).from(Vector2(0,0))
	
func _process(delta):
	$Sprite2D.rotation += rotation_speed * delta

func _on_body_entered(body):
	if "add_item" in body:
		body.add_item(type)
	queue_free()
