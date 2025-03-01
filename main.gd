extends Node2D

@onready var fire_light: PointLight2D = %FireLight

var inventory: Dictionary = {
	"yarn": 100,
	"fire": 0,
}  

var events: Dictionary = {
	"talked to guard 1": false,
	"talked to guard 2": false,
	"guard 2 hinted player once": false,
	"guard 2 hinted player twice": false,
	"guard 2 hinted player 3 times": false,
}

func give_fire():
	fire_light.visible = true
