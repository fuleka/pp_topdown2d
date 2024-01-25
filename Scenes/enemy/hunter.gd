extends CharacterBody2D

var active: bool = false
var speed: int = 200
var player_near: bool = false
var nav_loaded = false

func _ready():
	pass

func _physics_process(_delta):
	if !nav_loaded:#바보같지만, 오류한줄이 안나오게하는 방법이다.
		nav_loaded = true
		return
	var next_path_pos: Vector2 = $NavigationAgent2D.get_next_path_position()
	var direction: Vector2 = (next_path_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	if active:
		look_at(Global.player_pos)
	var look_angle = direction.angle()
	rotation = look_angle + PI / 2

func _on_find_timer_timeout():
	if active:
		$NavigationAgent2D.target_position = Global.player_pos

func _on_notice_area_body_entered(_body):
	active = true
	$AnimationPlayer.play('walk')

func _on_notice_area_body_exited(_body):
	active = false

func _on_attack_area_body_entered(body):
	player_near = true
	$AnimationPlayer.play('attack')

func _on_attack_area_body_exited(body):
	player_near = false

func attack():
	if player_near:
		Global.health -= 10
