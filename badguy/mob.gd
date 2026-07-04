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

var already_clicked = false
func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !already_clicked:
			print_debug("I've been left clicked D:")
			already_clicked = true
			print_debug("starting interaction options")
			var irt = interact.instantiate()
			add_child(irt)
			print_debug("self.position: ", self.position.x, ", ", self.position.y)
			print_debug("self.global_position: ", self.global_position.x, ", ", self.global_position.y)
			irt.position = Vector2(-100,0)
	
