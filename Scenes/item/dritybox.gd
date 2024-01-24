extends item

func hit():
	$BaseSprite.hide()
	if not opend:
		for i in range(5):
			var pos = $SpawnPoint.get_child(randi()%$SpawnPoint.get_child_count()).global_position
			itemcontainer_opend.emit(pos,current_direction)
		opend = true
