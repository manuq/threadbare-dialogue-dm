extends CanvasLayer

@onready var v_box_container: VBoxContainer = %VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(&"ui_cancel"):
		var current_scene = Engine.get_main_loop().current_scene
		var balloon: CanvasLayer = current_scene.get_node("DialogueBalloon")
		if balloon:
			return
		_on_back()

func _on_back() -> void:
	var current_scene = Engine.get_main_loop().current_scene
	var world: Node2D = current_scene.get_node("World")
	if world.process_mode == Node.PROCESS_MODE_INHERIT:
		world.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		world.process_mode = Node.PROCESS_MODE_INHERIT
	visible = not visible
	if visible:
		v_box_container.get_children()[0].grab_focus()
	
func _on_button_back_pressed() -> void:
	_on_back()


func _on_button_new_pressed() -> void:
	var scene_tree = Engine.get_main_loop() as SceneTree
	scene_tree.reload_current_scene()


func _on_button_quit_pressed() -> void:
	var scene_tree = Engine.get_main_loop() as SceneTree
	scene_tree.quit()
