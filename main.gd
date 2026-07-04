extends Node2D

@export var carFront: PackedScene
@export var carBack: PackedScene
@export var carLeft: PackedScene
@export var carRight: PackedScene
var cfront
var cback
var cleft
var cright

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
