extends Node2D

const TEST = preload("res://dialogue/test.dialogue")

@onready var fire_light: PointLight2D = %FireLight
@onready var npc: AnimatedSprite2D = %NPC

func _ready() -> void:
	DialogueManager.got_dialogue.connect(_on_got_dialogue)
	DialogueManager.show_dialogue_balloon(TEST, &"start", [self])

func _on_got_dialogue(line: DialogueLine):
	if line.character == "Guard" and "waving-torch" in line.tags:
		npc.wave_torch()

func give_fire():
	fire_light.visible = true
