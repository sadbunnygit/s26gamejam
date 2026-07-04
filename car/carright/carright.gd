extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("NEW CAR RIGHT LOADED")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:	
#	pass

func _on_look_front_pressed() -> void:
	print_debug("look front button pressed")
	WorldManager.load_world(WorldManager.cfront)

# Keyboard / Mouse input
func _input(event):
	if event.is_action_pressed("ui_left"):
		print("ui_left occurred!")
		_on_look_front_pressed()
