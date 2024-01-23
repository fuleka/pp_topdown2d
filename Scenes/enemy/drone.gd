extends CharacterBody2D

func _process(_delta):
	# direciton
	var direction = Vector2.RIGHT
	
	#velocity
	velocity = direction * 400
	
	#moveandsilde
	move_and_slide()
	
