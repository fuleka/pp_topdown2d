extends PathFollow2D

var player_near: bool = false
@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D2

func _ready():
	$Turret/Nozzlefire.hide()
	$Turret/Nozzlefire2.hide()
	
func fire():
	Global.health -= 10

func _process(delta):
	progress_ratio += 0.0001 * delta
	if player_near:
		$Turret.look_at(Global.player_pos)
		$AnimationPlayer.play('laser_load')

	
func _on_area_2d_body_entered(_body):
	player_near = true

	
func _on_area_2d_body_exited(_body):
	player_near = false
	if $AnimationPlayer.is_playing():
		$AnimationPlayer.stop()
