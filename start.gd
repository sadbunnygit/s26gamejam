extends Node2D

func _on_button_pressed() -> void:
	print_debug("start pressed")
	get_tree().change_scene_to_file("res://main.tscn")
	
	
func _ready() -> void:
	print_debug("NEW START LOADED")
	$music.play()
	$krobusChain.animation = "default"
	$krobusChain.play()
	$trees.animation = "default"
	$trees.play()
	$steeringWheel.animation = "both"
	$steeringWheel.play()
	$eject/up.show()
	$eject/down.hide()
