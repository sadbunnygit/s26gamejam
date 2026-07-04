extends Node2D

# for monster spawning
@export var mob_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("hi in front")
	_on_mob_timer_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:	
#	pass

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $mobPath/mobSpawnLoc
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)








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
