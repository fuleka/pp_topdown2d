extends CharacterBody2D

signal laser(pos, direction)
signal granade(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed

func _process(_delta):
	#input
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	Global.player_pos = global_position
	#rotat 마우스쪽으로 캐릭터 회전
	look_at(get_global_mouse_position())
	
	#캐릭터가 바라보는 방향 백터값
	var player_direction = (get_global_mouse_position() - position).normalized()
	
	# laser shooting input
	# 인풋 받으면 can_laser로 발사 가능한 상태인지 확인함. 레이저 포인트는 레이저가 발사될 위치고 3개 중 랜덤으로 생성함.
	# 그 다음 시그널을 통해 레이저 발사에 필요한 정보인 플레이어 디렉션과, 생성할 위치를 레벨에 알리면, 레벨에서 생성해줌. 이후 움직이는 건 레이저 씬에서 함.
	if Input.is_action_pressed("primay action") and can_laser and Global.laser_amount > 0:
		Global.laser_amount -= 1
		can_laser = false
		print('shootlaser')
		var laser_markers = $LaserPoint.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laser.emit(selected_laser.global_position, player_direction)
		print(selected_laser.position, player_direction)
		$Laser_shoot.start()
		$LaserPoint/Shootfire.emitting = true
		
	# 폭탄쏘는거, 컨트롤이나 마우스 우클
	if Input.is_action_pressed("secondary action") and can_grenade and Global.granade_amount > 0:
		Global.granade_amount -= 1
		can_grenade = false
		print('grenade')
		var granade_markers = $LaserPoint.get_children()
		var selected_granade = granade_markers[randi() % granade_markers.size()]
		$GranadeReloadTimer.start()
		granade.emit(selected_granade.global_position, player_direction)

func _on_timer_timeout():
	can_laser = true

func _on_granade_reload_timer_timeout():
	can_grenade = true

func add_item(type: String) -> void:
	if type == 'laser':
		Global.laser_amount += 5
	
	if type == 'granade':
		Global.granade_amount += 1
	
	if type == 'health':
		Global.health += 25
		
func hit():
	print('player hit')
	Global.health -= 10
	print(Global.health)


