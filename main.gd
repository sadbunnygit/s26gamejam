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
var humanSpawned = false

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
	$music.play()
	


func viewFront():
	print_debug()
	cfront.show()
	cback.hide()
	cleft.hide()
	cright.hide()
	if (passenger):
		passenger.hide()
	
func viewBack():
	print_debug()
	cback.show()
	cfront.hide()
	cleft.hide()
	cright.hide()
	if (passenger):
		passenger.show()
	
func viewLeft():
	print_debug()
	cleft.show()
	cback.hide()
	cfront.hide()
	cright.hide()
	if (passenger):
		passenger.hide()
	
func viewRight():
	print_debug()
	cright.show()
	cback.hide()
	cleft.hide()
	cfront.hide()
	if (passenger):
		passenger.hide()

func newPassenger(mob) -> void:
	print_debug("new passenger: ", mob)
	passenger = mob
	passenger.global_position = $pchair.position
	hasHuman = (passenger.type == Global.HUMAN)
	print_debug("human? ", hasHuman)
	viewBack()

func eject() -> void:
	print_debug("ejecting", passenger)
	if passenger == null:
		return
	passenger.get_node("Timer").stop()
	viewBack()
	if passenger.has_node("dialog"):
		passenger.get_node("dialog").queue_free()
	hasHuman = false
	cback.get_node("CarBackseatRoof").hide()
	cback.get_node("eject/springsound").play()
	cback.get_node("eject/spring").play()
	await get_tree().create_timer(0.3).timeout
	eject_ani()
	await get_tree().create_timer(2).timeout
	cback.get_node("eject/explosion").play()
	cback.get_node("eject/explodesound").play()
	passenger.queue_free()
	passenger = null
	cback.get_node("CarBackseatRoof").show()
	

func eject_ani():
	print_debug("eject ani running")
	var tween = create_tween()
	var tar_pos := Vector2(576,-1000)
	tween.tween_property(passenger, "position", tar_pos, 0.5)



func lose():
	get_tree().change_scene_to_file("res://loser.tscn")
func win():
	get_tree().change_scene_to_file("res://winner.tscn")
func neu():
	get_tree().change_scene_to_file("res://neu.tscn")

func _on_spawntimer_timeout() -> void: 
	var type = "monster_" + str(gamePhase)
	var side = randi_range(0,99)
	var speed = randf_range(2,5)
	var spawnHuman = randi_range(1,3) if gamePhase >= 3 else 0  # 1/3 chance for human spawn when available
	if spawnHuman == 3 && side <= 91 && !humanSpawned:
		speed = 0.5
		type = Global.HUMAN
		humanSpawned = true
		print_debug("HUMAN TIME DONT MISS IT")
	print_debug("spawning: ", type)
	if (side <= 25): #front
		cfront.spawn_mob(type, speed)
	elif (side <= 45): #back
		cback.spawn_mob(type, speed)
	elif (side <= 68): #left
		cleft.spawn_mob(type, speed)
	elif (side <= 91): #right
		cright.spawn_mob(type, speed)
	else:
		$spawnTimer.start(10)


func _on_gametimer_timeout() -> void: # 30 secs
	gamePhase += 1
	print_debug("gamePhase:",gamePhase)
	if gamePhase >= 3: # end game phase
		if humanSpawned:
			$gameTimer.stop()
			$spawnTimer.stop()
			if hasHuman:
				win()
			else:
				neu()
		else:
			gamePhase = 3


func _on_sound_timer_timeout() -> void:
	print_debug("sound maybe now")
	var sound = randi_range(1,9)
	if sound == 1:
		$soundTimer/scary1.play()
	if sound == 2:
		$soundTimer/scary2.play()	
	if sound == 3:
		$soundTimer/scary3.play()
