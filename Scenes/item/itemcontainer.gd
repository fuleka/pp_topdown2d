extends StaticBody2D
class_name item

signal itemcontainer_opend(pos, current_direction)

@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)
var opend: bool = false


func hit():
	print('obj')
