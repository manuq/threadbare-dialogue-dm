extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func wave_torch():
	animated_sprite_2d.play(&"wave")
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play(&"idle")

func look_right():
	animated_sprite_2d.flip_h = false

func look_left():
	animated_sprite_2d.flip_h = true
