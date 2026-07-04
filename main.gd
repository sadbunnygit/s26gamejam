extends Node2D

@export var carFront: PackedScene
@export var carBack: PackedScene
@export var carLeft: PackedScene
@export var carRight: PackedScene
var cfront
var cback
var cleft
var cright
var passenger
var hasHuman

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("main entered, _ready")
	cfront = carFront.instantiate()
	add_child(cfront)
	cback = carBack.instantiate()
	add_child(cback)
	cleft = carLeft.instantiate()
	add_child(cleft)
	cright = carRight.instantiate()
	add_child(cright)
	viewFront()
	

func viewFront():
	print_debug()
	cfront.show()
	cback.hide()
	cleft.hide()
	cright.hide()
	
func viewBack():
	print_debug()
	cback.show()
	cfront.hide()
	cleft.hide()
	cright.hide()
	
func viewLeft():
	print_debug()
	cleft.show()
	cback.hide()
	cfront.hide()
	cright.hide()
	
func viewRight():
	print_debug()
	cright.show()
	cback.hide()
	cleft.hide()
	cfront.hide()

func newPassenger(mob) -> void:
	print_debug("new passenger: ", mob)
	passenger = mob
	passenger.global_position = $pchair.position
	hasHuman = (passenger.type == "human")

func eject() -> void:
	print_debug("ejecting", passenger)
	if passenger != null:
		passenger.queue_free()
	passenger = null


func _on_spawn_enemy_pressed() -> void:
	cfront.spawn_mob()
	
	

func lose():
	get_tree().change_scene_to_file("res://loser.tscn")


func _on_timer_timeout() -> void: # every 5 seconds
	var side = randi_range(1,100)
	if (side <= 25): #front
		cfront.spawn_mob()
	elif (side <= 45): #back
		cback.spawn_mob()
	elif (side <= 68): #left
		cleft.spawn_mob()
	elif (side <= 91): #right
		cright.spawn_mob()
