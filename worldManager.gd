extends Node



var current_world = null
var world_root = null
var cfront = preload("res://car/carfront/carfront.tscn")
var cback  = preload("res://car/carback/carback.tscn")
var cleft  = preload("res://car/carleft/carleft.tscn")
var cright = preload("res://car/carright/carright.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_world(scene: PackedScene):
	if world_root == null:
		push_error("WorldRoot not assigned!")
		return
	# remove old world
	if current_world:
		current_world.queue_free()

	# create new world
	current_world = scene.instantiate()
	world_root.add_child(current_world)
