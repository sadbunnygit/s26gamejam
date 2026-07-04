extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("NEW CAR RIGHT LOADED")
	pass # Replace with function body.

func spawn_mob(type : String, speed : float = 1):
	var path = randi_range(1,2) 
	if (path == 1):
		print_debug("spawning mob from right path 1")
		$mobPath1/mobLoc.spawn_mob(type, speed)
	elif (path == 2):
		print_debug("spawning mob from right path 2")
		$mobPath2/mobLoc.spawn_mob(type, speed)

func _on_look_front_pressed() -> void:
	print_debug("look front button pressed")
	if get_parent() and get_parent().has_method("viewFront"):
		get_parent().viewFront()

# Keyboard / Mouse input
func _input(event):
	if event.is_action_pressed("ui_left"):
		print("ui_left occurred!")
		_on_look_front_pressed()
