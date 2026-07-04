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
var gamePhase = 0
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
	print_debug("human? ", hasHuman)

func eject() -> void:
	print_debug("ejecting", passenger)
	if passenger == null:
		return
	passenger.queue_free()
	passenger = null
	hasHuman = false
	cfront.get_node("eject/spring").play()
	await get_tree().create_timer(1.5).timeout
	cfront.get_node("eject/explode").play()
	
	


func lose():
	get_tree().change_scene_to_file("res://loser.tscn")
func win():
	get_tree().change_scene_to_file("res://winner.tscn")


func _on_spawntimer_timeout() -> void:  # 8 seconds rn
	var type = "monster_" + str(gamePhase)
	var side = randi_range(0,99)
	var speed = randf_range(2,5)
	var spawnHuman = randi_range(0,3) if gamePhase > 2 else 0  # 1/4 chance for human spawn when available
	if spawnHuman == 3:
		speed = 0.5
		type = "human"
	print_debug("spawning: ", type)
	if (side <= 25): #front
		cfront.spawn_mob(type, speed)
	elif (side <= 45): #back
		cback.spawn_mob(type, speed)
	elif (side <= 68): #left
		cleft.spawn_mob(type, speed)
	elif (side <= 91): #right
		cright.spawn_mob(type, speed)


func _on_gametimer_timeout() -> void: # 30 secs
	gamePhase += 1
	print_debug("gamePhase:",gamePhase)
	if gamePhase >= 4: # end game phase
		$gameTimer.stop()
		$spawnTimer.stop()
		if hasHuman:
			win()
		else:
			lose()
