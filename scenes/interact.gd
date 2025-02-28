extends Node2D

@onready var interact_ray: RayCast2D = %InteractRay
@onready var interact_label: Panel = %InteractLabel

@export var character: CharacterBody2D

var original_interact_ray_position: Vector2
var interacting: bool = false

func _ready() -> void:
	original_interact_ray_position = interact_ray.target_position

func _process_ray(delta: float) -> void:
	if not character:
		return
	if character.velocity.is_zero_approx():
		return
	if is_zero_approx(character.velocity.x):
		return
	if character.velocity.x < 0:
		interact_ray.target_position = original_interact_ray_position.reflect(Vector2.UP)
	else:
		interact_ray.target_position = original_interact_ray_position

func _process_label(delta: float) -> void:
	interact_label.visible = interact_ray.is_colliding()

func _process_interact(delta: float) -> void:
	if not interact_ray.is_colliding():
		return
	if Input.is_action_just_released(&"ui_accept"):
		interact_ray.get_collider().start_interaction(interact_ray.target_position.x < 0)
		interact_ray.get_collider().interaction_ended.connect(_on_interaction_ended)
		interact_label.visible = false
		interacting = true

func _process(delta: float) -> void:
	if interacting:
		return
	_process_ray(delta)
	_process_label(delta)
	_process_interact(delta)

func _on_interaction_ended():
	await get_tree().create_timer(0.5).timeout
	interacting = false
