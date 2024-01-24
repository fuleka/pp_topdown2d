extends Node

signal update_health
signal update_granade
signal update_laser

var laser_amount: int = 20:
	set(value):
		laser_amount = value
		update_laser.emit()

var granade_amount: int = 5:
	set(value):
		granade_amount = value
		update_granade.emit()

var player_can_hit: bool = true
var health: int = 50:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_can_hit:
				health = value
				player_can_hit = false
				player_cannot_hit_timer()
				update_health.emit()
var player_pos: Vector2

func player_cannot_hit_timer():
	await get_tree().create_timer(0.5).timeout
	player_can_hit = true
