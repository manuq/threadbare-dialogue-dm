extends CharacterBody2D

@export_range(10, 10000, 10) var SPEED = 12000.0
@export_range(10, 10000, 10) var RUN_SPEED = 24000.0
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

func _process(delta: float) -> void:
	
	var axis:Vector2 = Vector2(
		Input.get_axis(&"move_left", &"move_right"),
		Input.get_axis(&"move_up", &"move_down")
	)

	if Input.is_action_pressed(&"running"):
		velocity = axis * RUN_SPEED * delta
	else:
		velocity = axis * SPEED * delta
	
	animated_sprite_2d.flip_h = velocity.x < 0

	if velocity.is_zero_approx():
		animated_sprite_2d.play(&"idle")
	else:
		animated_sprite_2d.play(&"running")

	move_and_slide()
