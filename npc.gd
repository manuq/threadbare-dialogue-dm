extends AnimatedSprite2D

func wave_torch():
	play(&"wave")
	await animation_finished
	play(&"idle")
