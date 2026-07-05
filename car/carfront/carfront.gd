extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("NEW CAR FRONT LOADED")
	$krobusChain.animation = "default"
	$krobusChain.play()
	$trees.animation = "default"
	$trees.play()
	$steeringWheel.animation = "both"
	$steeringWheel.play()
	_on_paper_pressed()
	$eject/up.show()
	$eject/down.hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:	
#	pass


func spawn_mob(type : String, speed : float = 1):
	var path = randi_range(1, 6)
	print_debug("Spawning mob from front path %d" % path)
	get_node("mobPath%d/mobLoc" % path).spawn_mob(type, speed)		
		

# Look around buttons 
func _on_look_left_pressed() -> void:
	print_debug("look left button pressed")
	if get_parent() and get_parent().has_method("viewLeft"):
		get_parent().viewLeft()

func _on_look_right_pressed() -> void:
	print_debug("look right button pressed")
	if get_parent() and get_parent().has_method("viewRight"):
		get_parent().viewRight()
	
func _on_look_back_pressed() -> void:
	print_debug("look back button pressed")
	if get_parent() and get_parent().has_method("viewBack"):
		get_parent().viewBack()

# other interaction
func _on_eject_pressed() -> void:
	print_debug("eject pressed")
	$eject/down.show()
	$eject/up.hide()
	get_parent().eject()
	await get_tree().create_timer(0.2).timeout
	$eject/up.show()
	$eject/down.hide()
	


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


func _on_paper_pressed() -> void:
	print_debug("showing description")
	$DisplayPaper.show()
	$DisplayPaper/Danelle.hide()
	$DisplayPaper/Meghan.hide()
	$DisplayPaper/Sandy.hide()
	$DisplayPaper/Vicki.hide()
	if Global.HUMAN == "Danelle":
		$DisplayPaper/Danelle.show()
	if Global.HUMAN == "Meghan":
		$DisplayPaper/Meghan.show()
	if Global.HUMAN == "Sandy":
		$DisplayPaper/Sandy.show()
	if Global.HUMAN == "Vicki":
		$DisplayPaper/Vicki.show()
	
func _on_displaypaper_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print_debug("PAPER CLICKED")
			$DisplayPaper.hide()
