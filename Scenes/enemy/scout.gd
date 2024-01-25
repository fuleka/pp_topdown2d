extends CharacterBody2D

signal laser(pos, direction)

var player_nearby: bool = false
var can_laser: bool = true
var both_gun: bool = true
var health: int = 30
var can_hit: bool = true

func hit():
	if can_hit:
		health -= 10
		$Node/Hitcooldown.start()
		can_hit = false
		$Sprite2D.material.set_shader_parameter("progress",1)
	if health <= 0:
		queue_free()
	print('enemyhit')
	print(health)

func _process(_delta):
	if player_nearby:
		look_at(Global.player_pos)
		if can_laser:
			var marker_node = $LaserSpawnPosition.get_child(both_gun)
			both_gun = not both_gun
			var direction: Vector2 = (Global.player_pos - position).normalized()
			var pos: Vector2 = marker_node.global_position
			laser.emit(pos, direction)
			can_laser = false
			$Node/LaserCooldown.start()
	
	move_and_slide()


func _on_attack_area_body_entered(body):
	if body.name == 'player':
		player_nearby = true

func _on_attack_area_body_exited(body):
	if body.name == 'player':
		player_nearby = false

func _on_laser_cooldown_timeout():
	can_laser = true

func _on_hitcooldown_timeout():
	can_hit = true
	$Sprite2D.material.set_shader_parameter("progress",0)
