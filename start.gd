extends Node2D

func _on_button_pressed() -> void:
	print_debug("start pressed")
	get_tree().change_scene_to_file("res://main.tscn")
