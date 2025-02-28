extends Node2D

@onready var fire_light: PointLight2D = %FireLight

func give_fire():
	fire_light.visible = true
