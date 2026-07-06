extends Node2D

@export var interact: PackedScene
@export var dialogue: PackedScene
var type : String
var main


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("badguy entered")
	$monster.play()
	#get_tree().current_scene.print_tree_pretty()
	main = self.get_parent().get_parent().get_parent().get_parent()# should make it to main
	var ani = Global.HUMAN
	while (ani == Global.HUMAN && type == "monster_0"):
		ani = ["Dmon", "Mmon","Smon","Vmon"].pick_random()
	while (ani == Global.HUMAN && type == "monster_1"):
		ani = ["Dmon", "Mmon","Smon","Vmon","Danelle", "Meghan","Sandy","Vicki"].pick_random()
	while (ani == Global.HUMAN && type == "monster_2"):
		ani = ["Dmon", "Mmon","Smon","Vmon","Danelle", "Meghan","Sandy","Vicki"].pick_random()
	while (ani == Global.HUMAN && type == "monster_3"):
		ani = ["Danelle", "Meghan","Sandy","Vicki"].pick_random()
	if type == Global.HUMAN:
		print_debug("human entered!")
		ani = Global.HUMAN
	$AnimatedSprite2D.animation = ani
	$AnimatedSprite2D.play()
	$Timer.start(20)
	

func _on_timer_timeout() -> void:
	print_debug("timer timeout")
	if type == Global.HUMAN:
		return
	print_debug("monster kills")
	main.lose()

func restartTime() -> void:
	$Timer.start(0)


var already_clicked = false
func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and !already_clicked:
			print_debug("I've been left clicked D:")
			already_clicked = true
			print_debug("starting interaction options")
			var dialog = dialogue.instantiate()
			# set up different dialogs based on monster type
			if (Global.firstmob):
				print_debug("first mob so dialog at start")
				Global.firstmob = false
				dialog.dialogPath = "res://badguy/dialogs/first.json"
				add_child(dialog)
				dialog.name = "dialog"
				dialog.mob = self
				$Timer.stop() #reset
				dialog.global_position = Vector2(0,0)
				return
			var i = interact.instantiate()
			add_child(i)
			print_debug("self.position: ", self.position.x, ", ", self.position.y)
			print_debug("self.global_position: ", self.global_position.x, ", ", self.global_position.y)
			i.global_position = Vector2(0,0)
			i.mob = self
			i.name = "interact"
			if (main.passenger != null):
				i.get_node("letin").hide()
	
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
	if has_node("interact"):
		get_node("interact").queue_free()
	if has_node("Control"):
		get_node("Control").queue_free()
	if has_node("dialog"):
		get_node("dialog").queue_free()
	#print(self)
	#get_tree().current_scene.print_tree_pretty()
	reparent(main) 
	#get_tree().current_scene.print_tree_pretty()
	main.newPassenger(self)
	var dialog = dialogue.instantiate()
	# set up different dialogs based on monster type
	if (type == Global.HUMAN):
		dialog.dialogPath = "res://badguy/dialogs/good.json"
	else:
		var ran = randi_range(1,4)
		if (ran == 1):
			dialog.dialogPath = "res://badguy/dialogs/bad1.json"
		elif (ran == 2):
			dialog.dialogPath = "res://badguy/dialogs/bad2.json"
		elif (ran >= 3):
			dialog.dialogPath = "res://badguy/dialogs/neu1.json"
	dialog.mob = self
	add_child(dialog)
	dialog.mob = self
	dialog.name = "dialog"
	$Timer.stop() 
	dialog.global_position = Vector2(0,0)
