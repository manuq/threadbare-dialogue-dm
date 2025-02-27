extends Node2D

const TEST = preload("res://dialogue/test.dialogue")

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(TEST)
