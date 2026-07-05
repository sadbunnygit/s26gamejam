extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("NEW CAR LEFT LOADED")
	$trees.animation = "default"
	$trees.play()

func spawn_mob(type : String, speed : float = 1):
	var path = randi_range(1, 6)
	print_debug("Spawning mob from left path %d" % path)
	get_node("mobPath%d/mobLoc" % path).spawn_mob(type, speed)		
		

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
