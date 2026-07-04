extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("hi in front")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:	
#	pass



# Look around buttons 
func _on_look_left_pressed() -> void:
	print_debug("look left button pressed")
	get_tree().change_scene_to_file("res://scenes/carleft/carleft.tscn")

func _on_look_right_pressed() -> void:
	print_debug("look right button pressed")
	get_tree().change_scene_to_file("res://scenes/carright/carright.tscn")
	
func _on_look_back_pressed() -> void:
	print_debug("look back button pressed")
	get_tree().change_scene_to_file("res://scenes/carback/carback.tscn")

# other interaction
func _on_eject_pressed() -> void:
	print_debug("eject pressed")


# Keyboard / Mouse input
func _input(event):
	#print(event.as_text())
	if event.is_action_pressed("ui_left"):
		print("ui_left occurred!")
		_on_look_left_pressed()
	elif event.is_action_pressed("ui_right"):
		print("ui_right occurred!")
		_on_look_right_pressed()
	elif event.is_action_pressed("ui_down"):
		print("ui_down occurred!")
		_on_look_back_pressed()
