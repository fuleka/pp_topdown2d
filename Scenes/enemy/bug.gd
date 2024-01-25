extends CharacterBody2D

var active: bool = false
var speed: int = 150
var can_hit: bool = true
var player_near: bool = false
var health: int = 20

func _process(_delta):
	var direction = (Global.player_pos - position).normalized()
	look_at(Global.player_pos)
	if active:
		velocity = direction * speed
		move_and_slide()
		print('hi')

func hit():
	if can_hit:
		can_hit = false
		$Timers/HitTimer.start()
		health -= 10
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.5)
		$Particles/HitParticle.emitting = true
	if health <= 0:
		queue_free()
	print('bug was hit')
		

func _on_notice_area_body_entered(_body):
	$AnimatedSprite2D.play("walk")
	active = true

func _on_notice_area_body_exited(_body):
	$AnimatedSprite2D.stop()
	active = false

func _on_attack_area_body_entered(_body):
	$AnimatedSprite2D.play("attack")
	player_near = true
	
func _on_attack_area_body_exited(_body):
	player_near = false
	

func _on_animated_sprite_2d_animation_finished():
	if player_near:
		Global.health -= 10
	$Timers/AttackTimer.start()
		
func _on_attack_timer_timeout():
	if player_near:
		$AnimatedSprite2D.play("attack")

func _on_hit_timer_timeout():
	can_hit = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0.0)
