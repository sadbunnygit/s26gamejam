extends Node2D

@export var interact: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("badguy entered")
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.animation = "default"


func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print_debug("I've been left clicked D:")
			print_debug("starting interaction options")
			var irt = interact.instantiate()
			add_child(irt)
			irt.global_position = Vector2(0, 0) 
	
