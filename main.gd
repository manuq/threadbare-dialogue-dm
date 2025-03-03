extends Node2D

@onready var fire_light: PointLight2D = %FireLight

func _ready() -> void:
	if GameState.events.get("got lantern", false):
		got_lantern()

func got_lantern():
	fire_light.visible = true
