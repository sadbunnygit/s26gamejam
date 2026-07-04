extends Node2D

@export var interact: PackedScene
var type : String
var main


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("badguy entered")
	get_tree().current_scene.print_tree_pretty()
	main = self.get_parent().get_parent().get_parent().get_parent()# should make it to main
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.play()
	$Timer.start()
	

func _on_timer_timeout() -> void:
	print_debug("timer timeout")
	if type == "human":
		return
	print_debug("monster kills")
	main.lose()

var already_clicked = false
func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !already_clicked:
			print_debug("I've been left clicked D:")
			already_clicked = true
			print_debug("starting interaction options")
			var i = interact.instantiate()
			add_child(i)
			print_debug("self.position: ", self.position.x, ", ", self.position.y)
			print_debug("self.global_position: ", self.global_position.x, ", ", self.global_position.y)
			i.position = Vector2(-100,0)
			i.mob = self
			i.name = "interact"
	
func leave() -> void:
	print_debug("leaving")
	$Timer.stop()
	already_clicked = false
	$AnimatedSprite2D.stop()
	if has_node("interact"):
		get_node("interact").queue_free()
	if has_node("Control"):
		get_node("Control").queue_free()
	queue_free()

func enterCar() -> void:
	print_debug("trying to entering car")
	if (main.passenger != null):
		return # dont work!
	$Timer.start() #reset
	if has_node("interact"):
		get_node("interact").queue_free()
	if has_node("Control"):
		get_node("Control").queue_free()
	#print(self)
	#get_tree().current_scene.print_tree_pretty()
	reparent(main) 
	#get_tree().current_scene.print_tree_pretty()
	main.newPassenger(self)
