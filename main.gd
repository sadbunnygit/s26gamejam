extends Node2D

@export var carFront: PackedScene
@export var carBack: PackedScene
@export var carLeft: PackedScene
@export var carRight: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("main entered, _ready")
	var cfront = carFront.instantiate()
	add_child(cfront)
	var cback = carBack.instantiate()
	add_child(cback)
	cback.hide()
	var cleft = carLeft.instantiate()
	add_child(cleft)
	cleft.hide()
	var cright = carRight.instantiate()
	add_child(cright)
	cright.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
