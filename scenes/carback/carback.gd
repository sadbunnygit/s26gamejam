extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("hi in back")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:	
#	pass

func _on_look_front_pressed() -> void:
	print_debug("look front button pressed")
	get_tree().change_scene_to_file("res://scenes/carfront/carfront.tscn")

# Keyboard / Mouse input
func _input(event):
	print(event.as_text())
	if event.is_action_pressed("ui_up"):
		print("ui_up occurred!")
		_on_look_front_pressed()
