extends CharacterBody2D

var active: bool = false
var can_hit: bool = true
var max_speed: int = 250
var current_speed: int = 100
var health: int = 50
@export var shader_a: float = 0.5
var explosion_target = []

func _ready():
	$Explos.hide()
	$Sprite2D.show()
	
func _process(delta):
	if active:
		look_at(Global.player_pos)
		var direction = (Global.player_pos - position).normalized()
		velocity = direction * current_speed
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play('explos')
		
	if not can_hit:
		$Sprite2D.material.set_shader_parameter("progress",shader_a)
	
func hit():
	if can_hit:
		health -= 10
		can_hit = false
		var tween = get_tree().create_tween()
		tween.tween_property(self,"shader_a",0.0,0.5)
		$HitTimer.start()
	if health <= 0:
		$AnimationPlayer.play()

func _on_notice_area_body_entered(body):
	active = true
	if "player" in body:
		current_speed = max_speed
		

func _on_notice_area_body_exited(_body):
	active = false
	current_speed = 100

func _on_hit_timer_timeout():
	can_hit = true
	shader_a = 0.5

func _on_explosion_area_body_entered(body):
	explosion_target.append(body)
	
	await get_tree().create_timer(1).timeout
	for i in len(explosion_target):
		var target = explosion_target.pop_back()
		if "hit" in target: 
			target.hit()
	$AnimationPlayer.play("explos")
	
func _on_explosion_area_body_exited(body):
	for i in len(explosion_target):
		var find = explosion_target.find(body)
		if find >= 0:
			explosion_target.remove_at(i)
	
