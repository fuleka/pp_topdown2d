extends CanvasLayer

#color
var green: Color = Color(0,1,0,1)
var red: Color = Color(1,0,0,1)

@onready var laser_label: Label = $LaserCounter/VBoxContainer/Label
@onready var granade_label: Label = $GranadeCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var granade_icon: TextureRect = $GranadeCounter/VBoxContainer/TextureRect

func _ready():
	update_granade()
	update_laser()
	
func update_laser():
	laser_label.text = str(Global.laser_amount)
	update_color(Global.laser_amount,laser_label,laser_icon)
	
func update_granade():
	granade_label.text = str(Global.granade_amount)
	update_color(Global.granade_amount,granade_label,granade_icon)

func update_color(amount:int, label: Label, icon: TextureRect):
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
	elif amount > 0:
		label.modulate = green
		icon.modulate = green
	else:
		print('something wrong ui')
