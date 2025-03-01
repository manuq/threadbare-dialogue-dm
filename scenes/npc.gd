class_name NPC
extends CharacterBody2D

@export var dialogue: DialogueResource
@export var look_right: bool = false:
	set = _set_look_right

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var interact_area: Area2D = %InteractArea

func _ready() -> void:
	interact_area.interaction_started.connect(_on_interaction_started)
	_set_look_right(look_right)

func wave_torch():
	animated_sprite_2d.play(&"wave")
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play(&"idle")

func _set_look_right(new_look_right):
	look_right = new_look_right
	if not is_node_ready():
		return
	animated_sprite_2d.flip_h = look_right == false
	
func _on_interaction_started(from_left=false) -> void:
	look_right = from_left
	DialogueManager.got_dialogue.connect(_on_got_dialogue)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(dialogue)

func _on_got_dialogue(line: DialogueLine):
	if line.character == "Guard" and "waving-torch" in line.tags:
		wave_torch()

func _on_dialogue_ended(_dialogue_resource):
	DialogueManager.got_dialogue.disconnect(_on_got_dialogue)
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_ended)
	interact_area.interaction_ended.emit()
