extends item

func hit():
	$BaseSprite.hide()
	if not opend:
		var pos = $SpawnPoint.global_position
		itemcontainer_opend.emit(pos,current_direction)
		opend = true
