extends Area2D

@export var character: CharacterBody2D
@export var dialogue: DialogueResource

signal interaction_ended

func start_interaction(from_left=false):
	if from_left:
		character.look_right()
	else:
		character.look_left()
	DialogueManager.got_dialogue.connect(_on_got_dialogue)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.show_dialogue_balloon(dialogue)

func _on_got_dialogue(line: DialogueLine):
	if line.character == "Guard" and "waving-torch" in line.tags:
		character.wave_torch()

func _on_dialogue_ended(_dialogue_resource):
	interaction_ended.emit()
