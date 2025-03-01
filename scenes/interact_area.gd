extends Area2D

signal interaction_started(from_left: bool)
signal interaction_ended

func start_interaction(from_left=false):
	interaction_started.emit(from_left)
