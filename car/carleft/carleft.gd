extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("NEW CAR LEFT LOADED")
	spawn_mob()

func spawn_mob():
	var path = randi_range(1,2) 
	if (path == 1):
		print_debug("spawning mob from left path 1")
		$mobPath1/mobLoc.spawn_mob()
	elif (path == 2):
		print_debug("spawning mob from left path 2")
		$mobPath2/mobLoc.spawn_mob()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:	
#	pass

func _on_look_front_pressed() -> void:
	print_debug("look front button pressed")
	if get_parent() and get_parent().has_method("viewFront"):
		get_parent().viewFront()


# Keyboard / Mouse input
func _input(event):
	if event.is_action_pressed("ui_right"):
		print("ui_right occurred!")
		_on_look_front_pressed()
