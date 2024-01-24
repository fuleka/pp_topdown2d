extends Node2D
class_name Level_Parent

var laser_scene: PackedScene = preload("res://Scenes/projectile/laser.tscn")
var granade_scene: PackedScene = preload("res://Scenes/projectile/granade.tscn")
var item_scene: PackedScene = preload("res://Scenes/item/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("itemcontainer_opend", _on_cantainer_opend)
	for container in get_tree().get_nodes_in_group('Scout'):
		container.connect("laser", _on_scout_laser)


func _on_cantainer_opend(pos, direaction):
	var items = item_scene.instantiate()
	items.position = pos
	items.direction = direaction
	$items.call_deferred('add_child',items)
	
func _on_scout_laser(pos, direction):
	create_laser(pos, direction)
	
func _on_player_laser(pos, direction):
	create_laser(pos, direction)
	$hud.update_laser()

func create_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle())
	laser.direction = direction
	$projectile.add_child(laser)

	
func _on_player_granade(pos, direction):
	var granade = granade_scene.instantiate() as RigidBody2D
	granade.position = pos
	granade.linear_velocity = direction * 500
	$projectile.add_child(granade)
	$hud.update_granade()


func _on_house_player_entered():
	var my_tween = get_tree().create_tween()
	my_tween.tween_property($player/Camera2D,"zoom",Vector2(1,1),1)

func _on_house_player_exited():
	var my_tween = get_tree().create_tween()
	my_tween.tween_property($player/Camera2D,"zoom",Vector2(0.6,0.6),1)
