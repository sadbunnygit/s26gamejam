extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("hi in front")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:	
#	pass


func _on_look_left_button_pressed() -> void:
	print_debug("look left button pressed")
	get_tree().change_scene_to_file("res://src/carleft.tscn")


func _on_look_right_button_pressed() -> void:
	print_debug("look right button pressed")
	get_tree().change_scene_to_file("res://src/carright.tscn")
